# 🧬 Bash for Biological Data Analysis — Cheatsheet

> Cetak atau simpan halaman ini sebagai referensi cepat selama workshop!

---

## 📁 Navigasi & File

| Perintah | Fungsi | Contoh |
|----------|--------|--------|
| `pwd` | Tampilkan direktori saat ini | `pwd` |
| `ls -lh` | List file dengan ukuran manusiawi | `ls -lh data/` |
| `ls -la` | List semua file termasuk hidden | `ls -la` |
| `cd` | Pindah direktori | `cd ~/workshop/data` |
| `cd ..` | Naik satu direktori | `cd ..` |
| `cd -` | Kembali ke direktori sebelumnya | `cd -` |
| `mkdir -p` | Buat direktori (termasuk parent) | `mkdir -p results/qc` |
| `cp -r` | Salin file/direktori | `cp -r data/ backup/` |
| `mv` | Pindah atau rename | `mv old.fasta new.fasta` |
| `rm -i` | Hapus dengan konfirmasi | `rm -i temp.txt` |
| `tree` | Tampilkan struktur direktori | `tree project/` |

---

## 📄 Melihat Isi File

| Perintah | Fungsi | Contoh |
|----------|--------|--------|
| `cat` | Tampilkan seluruh isi file | `cat sequences.fasta` |
| `head -n 10` | Tampilkan 10 baris pertama | `head -n 20 reads.fastq` |
| `tail -n 10` | Tampilkan 10 baris terakhir | `tail -n 4 reads.fastq` |
| `less` | Baca file interaktif | `less big_file.fasta` |
| `wc -l` | Hitung jumlah baris | `wc -l sequences.fasta` |
| `wc -c` | Hitung jumlah karakter/bytes | `wc -c genome.fasta` |

---

## 🔍 Pencarian Teks — `grep`

```bash
grep "pattern" file.txt          # Cari pola dalam file
grep -i "pattern" file.txt       # Case-insensitive
grep -c "pattern" file.txt       # Hitung baris yang cocok
grep -v "pattern" file.txt       # Inverse (baris yang TIDAK cocok)
grep -n "pattern" file.txt       # Tampilkan nomor baris
grep -r "pattern" directory/     # Rekursif ke subdirektori
grep -E "pat1|pat2" file.txt     # Extended regex (OR)
grep "^>" sequences.fasta        # Cari baris yang mulai dengan >
grep -A 1 "^>" sequences.fasta   # Header FASTA + 1 baris berikutnya
```

---

## ✂️ Manipulasi Teks

### `cut` — Ambil kolom tertentu
```bash
cut -f 1 file.tsv            # Kolom 1 (tab-separated)
cut -f 1,3 file.tsv          # Kolom 1 dan 3
cut -d '|' -f 2 file.txt     # Gunakan | sebagai delimiter, ambil kolom 2
cut -d ',' -f 1-3 file.csv   # CSV, kolom 1 sampai 3
```

### `sort` — Urutkan data
```bash
sort file.txt                # Urutkan alfabetis
sort -n numbers.txt          # Urutkan numerik
sort -rn numbers.txt         # Urutkan numerik terbalik
sort -k2,2 file.tsv          # Urutkan berdasarkan kolom 2
sort -k2,2n -k1,1 file.tsv   # Kolom 2 numerik, lalu kolom 1 alfabetis
sort -u file.txt             # Urutkan dan hapus duplikat
```

### `uniq` — Hilangkan/hitung duplikat
```bash
sort file.txt | uniq          # Hapus baris duplikat
sort file.txt | uniq -c       # Hitung kemunculan setiap baris
sort file.txt | uniq -d       # Tampilkan hanya duplikat
sort file.txt | uniq -u       # Tampilkan hanya yang unik
```

### `awk` — Pemrosesan kolom & logika
```bash
awk '{print $1}' file.txt           # Cetak kolom 1
awk -F '\t' '{print $2}' file.tsv   # Tab-separated, kolom 2
awk '$3 > 1000' file.tsv            # Filter baris di mana kolom 3 > 1000
awk '{sum += $3} END {print sum}'   # Jumlahkan kolom 3
awk 'NR % 4 == 0' reads.fastq       # Ambil setiap baris ke-4 (quality FASTQ)
awk '/^>/{seq=""} !/^>/{seq=seq $0} END{print length(seq)}' seq.fa  # Panjang sekuens
```

### `sed` — Stream editor
```bash
sed 's/old/new/g' file.txt          # Replace semua "old" dengan "new"
sed 's/old/new/' file.txt           # Replace hanya kemunculan pertama
sed -i 's/old/new/g' file.txt       # Edit file langsung (in-place)
sed 's/ /_/g' file.txt              # Ganti spasi dengan underscore
sed '/^#/d' file.txt                # Hapus baris komentar
sed -n '10,20p' file.txt            # Cetak baris 10-20
sed 's/\r//' file.txt               # Hapus Windows line endings
```

### `tr` — Translate karakter
```bash
echo "hello" | tr 'a-z' 'A-Z'      # Lowercase ke uppercase
cat seq.fa | tr -d '\n'             # Hapus newline
cat seq.fa | tr 'ATGC' 'TACG'      # Komplemen DNA
```

---

## 🔗 Pipe & Redirection

```bash
cmd1 | cmd2               # Output cmd1 jadi input cmd2
cmd > file.txt            # Simpan output ke file (overwrite)
cmd >> file.txt           # Tambahkan output ke file (append)
cmd 2> error.log          # Redirect stderr ke file
cmd > out.txt 2>&1        # Redirect stdout dan stderr ke file
cmd < input.txt           # Baca input dari file
```

---

## 🧬 Format Bioinformatika

### FASTA
```bash
# Hitung jumlah sekuens
grep -c "^>" sequences.fasta

# Ekstrak semua header
grep "^>" sequences.fasta

# Ekstrak nama gen dari header (format: >ID|Org|Gene|...)
grep "^>" sequences.fasta | cut -d '|' -f 3

# Hitung total baris sekuens
grep -v "^>" sequences.fasta | wc -l

# Hitung GC content kasar
grep -v "^>" sequences.fasta | tr -d '\n' | tr -cd 'GCgc' | wc -c
```

### FASTQ
```bash
# Hitung jumlah reads (1 read = 4 baris)
echo $(($(wc -l < reads.fastq) / 4))

# Tampilkan read ke-1 (header + seq + + + quality)
head -n 4 reads.fastq

# Tampilkan hanya sequence reads
awk 'NR % 4 == 2' reads.fastq

# Tampilkan hanya quality scores
awk 'NR % 4 == 0' reads.fastq
```

### BED
```bash
# Hitung jumlah region
wc -l regions.bed

# Hitung region per kromosom
cut -f 1 regions.bed | sort | uniq -c | sort -rn

# Hitung panjang setiap region (end - start)
awk '{print $1, $2, $3, $3-$2}' regions.bed

# Filter region > 1000 bp
awk '($3-$2) > 1000' regions.bed

# Total panjang semua region
awk '{sum += ($3-$2)} END {print sum}' regions.bed
```

---

## 📊 Phred Quality Score

| Phred | ASCII | Akurasi | Error Rate |
|-------|-------|---------|-----------|
| 10 | `+` | 90% | 1/10 |
| 20 | `5` | 99% | 1/100 |
| 30 | `?` | 99.9% | 1/1000 |
| 40 | `I` | 99.99% | 1/10,000 |

**Rumus:** `Q = -10 × log₁₀(P)` di mana P = probabilitas error

---

## 📜 Bash Scripting

### Template Dasar
```bash
#!/usr/bin/env bash
set -euo pipefail

# Deskripsi singkat script

INPUT="${1:-}"   # Argumen pertama
OUTPUT="${2:-}"  # Argumen kedua

if [[ -z "$INPUT" ]]; then
    echo "Usage: $0 <input_file> [output_file]"
    exit 1
fi
```

### Variabel & Substitusi
```bash
NAME="workshop"              # Assign variabel
echo "$NAME"                 # Gunakan variabel
TODAY=$(date +%Y-%m-%d)      # Command substitution
NSEQ=$(grep -c "^>" file.fa) # Simpan hasil perintah
echo "Sequences: $NSEQ"
```

### Kondisional
```bash
if [[ -f "$FILE" ]]; then    # Cek file ada
    echo "File found"
elif [[ -d "$FILE" ]]; then  # Cek direktori ada
    echo "Is a directory"
else
    echo "Not found"
fi

# One-liner
[[ -f "$FILE" ]] && echo "exists" || echo "not found"
```

### Loop
```bash
# Loop file
for f in *.fasta; do
    echo "Processing: $f"
    grep -c "^>" "$f"
done

# Loop dengan counter
for i in {1..10}; do
    echo "Round $i"
done

# While loop
while IFS= read -r line; do
    echo "$line"
done < input.txt
```

### Kondisi File
```bash
-f "$file"   # File ada dan merupakan regular file
-d "$dir"    # Direktori ada
-e "$path"   # Path ada (file atau direktori)
-s "$file"   # File ada dan tidak kosong
-r "$file"   # File ada dan bisa dibaca
-z "$var"    # String kosong
-n "$var"    # String tidak kosong
```

---

## ⚡ Tips & Shortcuts

| Shortcut | Fungsi |
|----------|--------|
| `Tab` | Auto-complete nama file/perintah |
| `↑` / `↓` | Navigasi history perintah |
| `Ctrl+C` | Hentikan perintah yang berjalan |
| `Ctrl+L` | Clear terminal |
| `Ctrl+A` | Pindah ke awal baris |
| `Ctrl+E` | Pindah ke akhir baris |
| `Ctrl+R` | Cari dalam history |
| `!!` | Ulangi perintah terakhir |
| `!$` | Gunakan argumen terakhir dari perintah sebelumnya |
| `history | grep "grep"` | Cari perintah grep di history |

---

## 🗂️ Struktur Proyek Bioinformatika

```
my_project/
├── data/           # Raw data (JANGAN diubah!)
│   ├── raw/
│   └── reference/
├── results/        # Output analisis
│   ├── qc/
│   ├── alignment/
│   └── reports/
├── scripts/        # Bash/Python scripts
├── logs/           # Log files
└── README.md       # Dokumentasi proyek
```

---

## 🔧 Perintah Berguna Lainnya

```bash
# Ukuran file/direktori
du -sh directory/
du -sh * | sort -h

# Kompresi
gzip file.fasta          # Kompres → file.fasta.gz
gunzip file.fasta.gz     # Decompress
zcat file.fasta.gz       # Baca tanpa decompress
zgrep "^>" file.fasta.gz # grep pada file terkompresi

# Download file
wget https://example.com/file.fasta
curl -O https://example.com/file.fasta

# Cek proses berjalan
top         # Monitor resource
htop        # Monitor interaktif (jika tersedia)
ps aux | grep python  # Cari proses spesifik

# Waktu eksekusi
time bash myscript.sh   # Ukur waktu berjalan
```

---

*Workshop "Bash for Biological Data Analysis" · OmicsLite · 18 Juli 2026*
