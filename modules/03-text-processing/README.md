# 🔍 Modul 3 — Pengolahan Teks dengan Bash

> **Durasi:** ~30 menit | **Level:** Pemula–Menengah
>
> *"80% pekerjaan bioinformatika adalah memproses teks."*

---

## 3.1 Grep — Global Regular Expression Print

`grep` adalah senjata utama bioinformatician. Digunakan untuk **mencari pola** dalam file.

### Sintaks dasar
```bash
grep "pola" file.txt
```

### Contoh-contoh penting
```bash
# Cari teks sederhana
grep "ATCG" sequences.fasta

# Case insensitive (-i)
grep -i "atcg" sequences.fasta

# Tampilkan nomor baris (-n)
grep -n ">" sequences.fasta

# Hitung jumlah kemunculan (-c)
grep -c ">" sequences.fasta

# Tampilkan yang TIDAK mengandung pola (-v = invert)
grep -v ">" sequences.fasta

# Cari di banyak file sekaligus
grep ">" *.fasta

# Cari rekursif di semua file dalam direktori (-r)
grep -r "BRCA1" data/

# Tampilkan konteks sekitar hasil (3 baris sebelum dan sesudah)
grep -A 1 ">" sequences.fasta   # A = After
grep -B 1 "GATK" log.txt        # B = Before
grep -C 2 "ERROR" pipeline.log  # C = Context (sebelum & sesudah)

# Exact word match (-w)
grep -w "chr1" regions.bed

# Tampilkan nama file saja (-l = list files only)
grep -l "homo_sapiens" *.fasta

# Hitung total matches di semua file
grep -c ">" *.fasta
```

### Grep untuk FASTA files (sangat sering digunakan!)
```bash
# Hitung jumlah sequence (header dimulai dengan >)
grep -c "^>" sequences.fasta

# Tampilkan semua header
grep "^>" sequences.fasta

# Cari sequence dari organisme tertentu
grep "Homo sapiens" sequences.fasta

# Cari header yang mengandung gen tertentu
grep -i "BRCA1\|TP53\|KRAS" sequences.fasta
```

---

## 3.2 Wc — Word Count

```bash
# Hitung baris, kata, dan karakter
wc sequences.fasta
# Output: 120  450  8930 sequences.fasta
#          │    │    └── karakter
#          │    └─────── kata
#          └──────────── baris (lines)

# Hitung baris saja (-l = lines)
wc -l sequences.fasta

# Hitung karakter saja (-c = characters)
wc -c sequences.fasta

# Hitung kata saja (-w = words)
wc -w sequences.fasta

# Praktis: hitung jumlah sequence dalam FASTA
grep -c "^>" sequences.fasta

# Atau kombinasikan:
grep "^>" sequences.fasta | wc -l
```

---

## 3.3 Cut — Memotong Kolom

`cut` digunakan untuk mengambil kolom tertentu dari file yang terstruktur (TSV, CSV, BED, GFF).

```bash
# Ambil karakter ke-1 sampai 10
cut -c 1-10 file.txt

# Ambil kolom tertentu (field) dari file TSV
# -d '\t' = delimiter tab, -f 1 = field ke-1
cut -d $'\t' -f 1 annotation.bed

# Ambil kolom 1 dan 3 dari file BED (chr dan end position)
cut -f 1,3 regions.bed

# Ambil kolom 1-3
cut -f 1-3 regions.bed

# Untuk file CSV (koma sebagai delimiter)
cut -d ',' -f 2 metadata.csv

# Contoh dengan file GFF (tab-delimited):
# Chr  Source  Feature  Start  End  Score  Strand  Frame  Attribute
cut -f 1,3,4,5 annotation.gff  # Ambil Chr, Feature, Start, End
```

---

## 3.4 Sort — Mengurutkan

```bash
# Urut alfabetis (default)
sort gene_list.txt

# Urut angka (-n = numeric)
sort -n scores.txt

# Urut terbalik (-r = reverse)
sort -r gene_list.txt
sort -rn scores.txt

# Urut berdasarkan kolom tertentu (-k = key)
sort -k2,2n regions.bed      # Urut berdasarkan kolom 2 (numerik)
sort -k1,1 -k2,2n regions.bed  # Urut kolom 1 dulu, lalu kolom 2

# Hapus duplikat saat sorting (-u = unique)
sort -u gene_list.txt

# Sort file BED (standar bioinformatika)
sort -k1,1 -k2,2n regions.bed > regions_sorted.bed
```

---

## 3.5 Uniq — Menangani Duplikat

> ⚠️ `uniq` hanya bekerja pada file yang **sudah diurutkan!**

```bash
# Hapus baris duplikat berurutan
sort gene_list.txt | uniq

# Hitung kemunculan setiap baris (-c = count)
sort gene_list.txt | uniq -c

# Tampilkan hanya yang duplikat (-d = duplicated)
sort gene_list.txt | uniq -d

# Tampilkan hanya yang unik (-u = unique only)
sort gene_list.txt | uniq -u

# Contoh: Hitung berapa kali tiap kromosom muncul di file BED
cut -f 1 regions.bed | sort | uniq -c | sort -rn
```

---

## 3.6 Pipe (|) — Menggabungkan Perintah

**Pipe** adalah senjata paling powerful di bash! Ia mengirim **output** dari satu perintah sebagai **input** ke perintah berikutnya.

```
perintah1 | perintah2 | perintah3 | ...
```

![Cara kerja pipe](../../assets/diagrams/how-pipes-work.svg)

### Contoh pipeline bioinformatika:
```bash
# Hitung jumlah sequence unik berdasarkan organisme
grep "^>" sequences.fasta | cut -d '|' -f 2 | sort | uniq -c | sort -rn

# Tampilkan 5 kromosom paling banyak region
cut -f 1 annotation.bed | sort | uniq -c | sort -rn | head -5

# Cari sequence mengandung ATG (start codon), ambil headernya
grep -B 1 "ATG" sequences.fasta | grep "^>"

# Hitung GC content kasar
grep -v "^>" sequences.fasta | tr -cd 'GCgc' | wc -c
```

---

## 3.7 Redirection — Menyimpan Output

```bash
# > Simpan output ke file (OVERWRITE jika sudah ada!)
grep "^>" sequences.fasta > headers.txt

# >> Tambahkan output ke file (APPEND)
grep "^>" more_sequences.fasta >> headers.txt

# < Baca input dari file
wc -l < sequences.fasta

# 2> Redirect error messages
grep "ATCG" *.fasta 2> error.log

# &> Redirect output DAN error
bwa mem reference.fasta reads.fastq &> alignment.log

# /dev/null: buang output (jangan tampilkan apapun)
grep "ATCG" sequences.fasta > /dev/null 2>&1
```

### `tee` — Simpan ke file DAN tampilkan di layar
```bash
grep "^>" sequences.fasta | tee headers.txt
# → Tampil di layar SEKALIGUS tersimpan di headers.txt
```

---

## 3.8 Awk — Pemrosesan Kolom Tingkat Lanjut

`awk` sangat powerful untuk file tabular (BED, GFF, TSV):

```bash
# Sintaks dasar: awk '{action}' file
# Variabel otomatis: $0 = seluruh baris, $1 = kolom 1, $2 = kolom 2, NR = nomor baris

# Cetak kolom pertama
awk '{print $1}' regions.bed

# Cetak kolom 1 dan 3
awk '{print $1, $3}' regions.bed

# Cetak dengan separator custom
awk '{print $1 "\t" $2 "\t" $3}' regions.bed

# Hitung panjang region dari file BED ($3 = end, $2 = start)
awk '{print $1, $2, $3, $3-$2}' regions.bed

# Filter baris berdasarkan nilai kolom (region > 1000 bp)
awk '($3 - $2) > 1000' regions.bed

# Filter kromosom tertentu
awk '$1 == "chr1"' regions.bed

# Hitung total panjang semua region
awk '{sum += $3 - $2} END {print "Total:", sum, "bp"}' regions.bed

# Tambahkan header ke output
awk 'BEGIN {print "Chr\tStart\tEnd\tLength"} {print $1, $2, $3, $3-$2}' regions.bed

# Proses file GFF - ambil gene saja
awk '$3 == "gene"' annotation.gff

# Hitung rata-rata panjang feature
awk '{sum += $5 - $4; count++} END {print "Average:", sum/count}' annotation.gff
```

---

## 3.9 Sed — Stream Editor

`sed` digunakan untuk **mencari dan mengganti** teks, serta transformasi sederhana:

```bash
# Sintaks dasar: sed 's/pola_lama/pola_baru/' file

# Ganti teks pertama di setiap baris
sed 's/chr/chromosome/' regions.bed

# Ganti SEMUA kemunculan di tiap baris (g = global)
sed 's/chr/chromosome/g' regions.bed

# Simpan perubahan ke file (i = in-place)
sed -i 's/chr/Chr/g' regions.bed

# 🍎 Catatan Pengguna macOS (Mac):
# sed di macOS memiliki perilaku berbeda. Kamu harus menambahkan '' setelah -i:
# sed -i '' 's/chr/Chr/g' regions.bed

# Ganti di baris tertentu (baris ke-5)
sed '5s/old/new/' file.txt

# Hapus baris yang mengandung pola
sed '/^#/d' annotation.gff           # Hapus baris komentar (#)
sed '/^$/d' sequences.fasta          # Hapus baris kosong

# Tampilkan hanya baris tertentu (seperti head/tail)
sed -n '1,10p' sequences.fasta        # Baris 1-10
sed -n '5p' sequences.fasta           # Hanya baris 5

# Ganti tab dengan spasi
sed 's/\t/ /g' regions.bed

# Uppercase/lowercase (dengan tr lebih mudah):
tr 'a-z' 'A-Z' < sequences.fasta     # Uppercase
tr 'atcg' 'ATCG' < sequences.fasta   # Uppercase nukleotida saja
```

---

## 3.10 Tr — Translate/Transform

```bash
# Ubah huruf kecil ke kapital
tr 'a-z' 'A-Z' < input.txt

# Ubah huruf kapital ke kecil
tr 'A-Z' 'a-z' < input.txt

# Hapus karakter tertentu (-d = delete)
tr -d '\n' < sequences.fasta   # Hapus newline

# Hitung karakter G dan C dalam sequence
grep -v "^>" sequences.fasta | tr -cd 'GCgc' | wc -c
```

---

## 🧬 Mini Quiz — Identifikasi Perintah

Apa yang dilakukan perintah berikut?

```bash
# Perintah 1:
grep "^>" sequences.fasta | wc -l

# Perintah 2:
cut -f 1 regions.bed | sort | uniq -c | sort -rn | head -5

# Perintah 3:
awk '$3 == "gene" {print $1, $4, $5, $3-$2}' annotation.gff | sort -k4,4n

# Perintah 4:
grep -v "^>" sequences.fasta | tr -d '\n' | wc -c
```

<details>
<summary>👀 Klik untuk melihat jawaban</summary>

1. Hitung total sequences dalam file FASTA
2. Tampilkan 5 kromosom terbanyak dalam file BED
3. Ambil semua gene, cetak posisi dan panjangnya, urutkan dari terpendek
4. Hitung total nukleotida (tanpa header) dalam file FASTA

</details>

---

## ✅ Checkpoint Modul 3

- [ ] `grep` dengan berbagai flag (-i, -v, -c, -n, -r)
- [ ] `wc -l` untuk menghitung baris
- [ ] `cut -f` untuk mengambil kolom
- [ ] `sort` dan `uniq` untuk analisis distribusi
- [ ] Pipe `|` untuk menggabungkan perintah
- [ ] Redirection `>` dan `>>` untuk menyimpan output
- [ ] `awk` untuk filter dan kalkulasi kolom
- [ ] `sed` untuk search and replace

---

**➡️ Lanjut ke:** [`../04-biological-formats/README.md`](../04-biological-formats/README.md)

---

*Modul 3 dari 5 | Workshop Bash for Biological Data Analysis — OmicsLite 2026*
