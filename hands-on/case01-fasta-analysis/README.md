# 🧬 Case Study 1 — Analisis File FASTA

> **Level:** Beginner
> **Data:** `data/sequences.fasta`

---

## 🕵️‍♂️ Latar Belakang: Kasus "Detektif Bakteri" (Bacterial Detective)

**Skenario**: Terjadi insiden kontaminasi sampel misterius di laboratorium utama kota. Tim medis mendeteksi adanya infeksi pada beberapa pasien, tetapi belum bisa mengidentifikasi mikroorganisme apa saja yang terlibat. Mereka berhasil mengekstrak beberapa sekuens gen penanda (marker) dari sampel pasien dan meletakkannya di satu file FASTA: `data/sequences.fasta`.

Sebagai seorang **Detektif Bioinformatika (Bioinformatics Detective)**, tugasmu adalah menyelidiki file barang bukti ini **hanya menggunakan command line bash** — tanpa Python, tanpa R, dan tanpa bantuan web-tool grafis!

---

## 🎯 Misi Investigasi

Di akhir penyelidikan ini, kamu harus berhasil:
1. **Mengukur skala bukti**: Memastikan berapa banyak sekuens yang berhasil diisolasi.
2. **Melacak asal-usul**: Mengetahui organisme tersangka apa saja yang ada di dalam sampel dan mana yang paling mendominasi.
3. **Membongkar data gen**: Menganalisis komposisi nukleotida dan persentase GC content.
4. **Mengisolasi tersangka utama**: Memisahkan sekuens milik inang manusia (*Homo sapiens*) ke file terpisah untuk analisis medis darurat.
5. **Membuat sistem otomatis**: Membuat script pelaporan otomatis jika nanti ditemukan barang bukti baru.

---

## 📋 Persiapan

```bash
# Pastikan kamu berada di direktori yang benar
cd hands-on/case01-fasta-analysis/

# Lihat file yang tersedia
ls -lh data/

# Preview file FASTA
head -20 data/sequences.fasta
```

---

## 📝 Task 1: Eksplorasi Awal

### 1.1 Lihat isi file
```bash
# Tampilkan 20 baris pertama
head -20 data/sequences.fasta

# Tampilkan 5 baris terakhir
tail -5 data/sequences.fasta

# Hitung total baris dalam file
wc -l data/sequences.fasta
```

**❓ Pertanyaan:**
- Berapa total baris dalam file?
- Bagaimana format header dalam file ini?
- Informasi apa saja yang ada di header?

### 1.2 Hitung jumlah sequence
Tugas kamu: **hitung berapa sequence yang ada dalam file ini**

💡 Petunjuk: Header sequence selalu dimulai dengan karakter `>`

```bash
# Coba tulis perintahmu di sini:
# ...

# Expected output: sebuah angka
```

<details>
<summary>🔍 Petunjuk lebih lanjut (klik jika perlu)</summary>

```bash
grep "^>" data/sequences.fasta | wc -l
# atau
grep -c "^>" data/sequences.fasta
```

</details>

---

## 📝 Task 2: Analisis Header

Header dalam file ini memiliki format:
```
>geneID|Organism|GeneName|Region|Note
```

### 2.1 Tampilkan semua header
```bash
grep "^>" data/sequences.fasta
```

### 2.2 Ekstrak informasi per kolom dari header

Misalkan kita ingin tahu **dari organisme apa saja** sequence dalam file ini.

```bash
# Ambil kolom 2 dari header (nama organisme)
# Header dipisahkan oleh | (pipe character)
grep "^>" data/sequences.fasta | cut -d '|' -f 2

# Urutkan dan tampilkan unique organisme
grep "^>" data/sequences.fasta | cut -d '|' -f 2 | sort -u
```

### 2.3 Hitung sequence per organisme

**Tugas:** Buat tabel yang menunjukkan berapa sequence dari setiap organisme!

💡 Petunjuk: Kombinasikan `grep`, `cut`, `sort`, dan `uniq -c`

```bash
# Coba tulis perintahmu di sini:
# ...

# Expected output:
#       2 Arabidopsis thaliana
#       1 Danio rerio
#       2 Escherichia coli K-12
#       3 Homo sapiens
# ... dst
```

<details>
<summary>🔍 Petunjuk</summary>

```bash
grep "^>" data/sequences.fasta | cut -d '|' -f 2 | sort | uniq -c | sort -rn
```

</details>

### 2.4 Daftar nama gen

**Tugas:** Tampilkan semua nama gen yang ada dalam file (kolom ke-3 dari header)!

```bash
# Coba tulis perintahmu di sini:
# ...
```

---

## 📝 Task 3: Analisis Sequence

### 3.1 Hitung total nukleotida

**Tugas:** Berapa total nukleotida dalam seluruh file?

💡 Petunjuk:
- Ambil semua baris yang BUKAN header (tanpa `>`)
- Hapus newline dan spasi
- Hitung karakter yang tersisa

```bash
# Coba tulis perintahmu di sini:
# ...
```

<details>
<summary>🔍 Petunjuk</summary>

```bash
grep -v "^>" data/sequences.fasta | tr -d '\n ' | wc -c
```

</details>

### 3.2 Hitung GC content keseluruhan

**Rumus:**
```
GC% = (jumlah G + C) / (total nukleotida) × 100
```

**Tugas:** Hitung GC content dari seluruh file!

```bash
# Langkah 1: hitung total nukleotida
TOTAL=$(grep -v "^>" data/sequences.fasta | tr -d '\n ' | wc -c)

# Langkah 2: hitung G dan C
GC=$(grep -v "^>" data/sequences.fasta | tr -cd 'GCgc' | wc -c)

# Langkah 3: hitung persentase (gunakan bc untuk kalkulasi desimal)
echo "scale=2; $GC * 100 / $TOTAL" | bc
echo "% GC content"
```

### 3.3 Hitung AT vs GC ratio

**Tugas:** Berapa AT content? Berapa AT/GC ratio?

```bash
# Hitung AT
AT=$(grep -v "^>" data/sequences.fasta | tr -cd 'ATat' | wc -c)
echo "AT count: $AT"

# Coba hitung AT%
# ...

# Coba hitung AT/GC ratio
# ...
```

---

## 📝 Task 4: Filter Sequence

### 4.1 Ekstrak sekuens dari organisme tertentu

**Tugas:** Ekstrak semua sekuens dari **Homo sapiens** ke file baru!

💡 **Tantangan**: Karena baris sekuens pada FASTA ini terbagi menjadi beberapa baris (multi-line), perintah `grep` biasa akan kesulitan mengambil sekuens secara utuh. Cara paling mudah dan populer di bioinformatika adalah menggunakan `awk` dengan mendefinisikan pembatas rekam (*Record Separator*) `RS=">"`:

```bash
# Menggunakan trik awk RS=">" untuk mengambil record Homo sapiens secara utuh
awk -v RS=">" 'NR>1 && /Homo sapiens/ {printf ">%s", $0}' data/sequences.fasta > human_sequences.fasta

# Verifikasi hasilnya (hitung jumlah sekuens di file baru)
grep -c "^>" human_sequences.fasta
```


---

## 📝 Task 5: Script Pelaporan Otomatis

Gunakan berkas template/skeleton script `analyze_fasta_template.sh` yang telah disediakan. Tugas Anda adalah melengkapi bagian `# TODO` di dalamnya agar script tersebut dapat berjalan otomatis menganalisis file FASTA apa saja yang dimasukkan sebagai argumen.

1. Buka berkas `analyze_fasta_template.sh` di editor.
2. Lengkapi TODO 1 s.d. TODO 5 menggunakan perintah dasar yang telah Anda pelajari.
3. Jalankan dan uji script Anda dengan perintah berikut:

```bash
bash analyze_fasta_template.sh data/sequences.fasta
```

---

## ✅ Checklist Penyelesaian

- [ ] Task 1: Bisa membaca dan explore file FASTA
- [ ] Task 2: Bisa mengekstrak info dari header dengan `cut`
- [ ] Task 2: Bisa menghitung distribusi per organisme
- [ ] Task 3: Bisa menghitung total nukleotida
- [ ] Task 3: Bisa menghitung GC content
- [ ] Task 4: Bisa memfilter sequence berdasarkan organisme
- [ ] Task 5 (Bonus): Membuat script analisis

---

## 📊 Expected Output Summary

Setelah menyelesaikan semua task, kamu harusnya mengetahui:

| Informasi | Nilai |
|-----------|-------|
| Jumlah sequence | ? |
| Total nukleotida | ? |
| GC content (%) | ? |
| Jumlah organisme | ? |
| Sequence terpanjang | ? |

---

**🔍 Solusi lengkap:** [`solutions/solution.sh`](solutions/solution.sh) *(lihat setelah mencoba!)*

---

*Case Study 1 | Workshop Bash for Biological Data Analysis — OmicsLite 2026*
