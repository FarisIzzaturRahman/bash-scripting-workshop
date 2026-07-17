# 📁 Modul 2 — Navigasi File & Direktori

> **Durasi:** ~15 menit | **Level:** Pemula
>
> *"Bioinformatician yang baik tahu di mana file mereka berada."*

---

## 2.1 Perintah Navigasi Dasar

### `pwd` — Print Working Directory
```bash
pwd
# Output: /home/username/workshop
```

### `ls` — List (melihat isi direktori)
```bash
# Daftar sederhana
ls

# Format panjang (-l): permission, owner, size, tanggal
ls -l

# Tampilkan file tersembunyi (-a, dimulai dengan titik)
ls -a

# Format panjang + ukuran mudah dibaca (-lh = human readable)
ls -lh

# Urutkan berdasarkan waktu (terbaru pertama)
ls -lt

# Rekursif — tampilkan isi semua subdirektori
ls -R

# Kombinasi flag
ls -lah
```

**Contoh output `ls -lh`:**
```
total 48K
drwxr-xr-x 3 user user 4.0K Jul 18 10:00 data/
-rw-r--r-- 1 user user  12K Jul 18 09:55 sequences.fasta
-rw-r--r-- 1 user user  24K Jul 18 09:50 reads.fastq
-rw-r--r-- 1 user user 2.1K Jul 18 09:45 regions.bed
```

> 💡 **Arti kolom:** permissions | links | owner | group | size | date | name

### `cd` — Change Directory
```bash
# Masuk ke direktori
cd workshop/
cd /home/username/data/

# Kembali ke home
cd ~
cd         # (tanpa argumen = langsung ke home)

# Naik satu level
cd ..

# Naik dua level
cd ../..

# Kembali ke direktori sebelumnya
cd -

# Masuk ke direktori dengan nama panjang (gunakan Tab!)
cd bioin[TAB]  # → bash akan auto-complete!
```

---

## 2.2 Path: Absolute vs Relative

```
Filesystem:
/home/username/
    └── workshop/
        ├── data/
        │   ├── sequences.fasta
        │   └── reads.fastq
        └── results/
```

### Absolute Path (dari root `/`)
```bash
# Selalu dimulai dengan /
cat /home/username/workshop/data/sequences.fasta

# Berlaku dari mana saja kamu berada
```

### Relative Path (dari lokasi saat ini)
```bash
# Jika kamu di /home/username/workshop/
cat data/sequences.fasta        # ← relative!
cat ./data/sequences.fasta      # (./  = di sini)

# Jika kamu di /home/username/workshop/results/
cat ../data/sequences.fasta     # (../ = naik satu level dulu)
```

> 💡 **Tips:** Gunakan `pwd` untuk tahu di mana kamu sebelum menggunakan relative path!

---

## 2.3 Membuat & Menghapus Direktori

### `mkdir` — Make Directory
```bash
# Buat satu direktori
mkdir results

# Buat direktori bersarang (gunakan -p)
mkdir -p project/data/raw
mkdir -p project/data/processed
mkdir -p project/results/figures

# Buat beberapa direktori sekaligus
mkdir raw_data processed_data results logs
```

### Struktur direktori bioinformatika yang umum:
```bash
# Buat struktur project standar
mkdir -p my_project/{data/{raw,processed,reference},results/{qc,alignment,expression},scripts,logs,docs}

# Lihat hasilnya
tree my_project/
# Output:
# my_project/
# ├── data/
# │   ├── raw/
# │   ├── processed/
# │   └── reference/
# ├── results/
# │   ├── qc/
# │   ├── alignment/
# │   └── expression/
# ├── scripts/
# ├── logs/
# └── docs/
```

### `rmdir` — Remove Directory (hanya jika kosong)
```bash
rmdir direktori_kosong/
```

---

## 2.4 Manajemen File

### `cp` — Copy
```bash
# Salin file
cp sequences.fasta sequences_backup.fasta

# Salin ke direktori lain
cp sequences.fasta backup/

# Salin direktori beserta isinya (-r = recursive)
cp -r data/ data_backup/

# Salin dengan verbose (-v = tampilkan progres)
cp -v large_file.fastq backup/
```

### `mv` — Move / Rename
```bash
# Rename file
mv sequences.fasta sequences_v1.fasta

# Pindah ke direktori lain
mv sequences.fasta data/raw/

# Pindah dan ganti nama
mv old_name.txt data/new_name.txt

# Pindah banyak file sekaligus
mv *.fastq data/raw/
```

### `rm` — Remove (HATI-HATI! Tidak ada recycle bin!)
```bash
# Hapus file
rm file_tidak_perlu.txt

# Hapus direktori beserta isinya
rm -r direktori_lama/

# Konfirmasi sebelum hapus (-i = interactive)
rm -i penting.fasta

# ⚠️ JANGAN LAKUKAN INI:
# rm -rf /     ← Hapus seluruh sistem!
# rm -rf ~/*   ← Hapus semua file home!
```

> ⚠️ **Peringatan:** `rm` di Linux **permanen**! Tidak ada "Recycle Bin". Selalu cek dua kali!

### `touch` — Buat file kosong / Update timestamp
```bash
# Buat file kosong
touch catatan.txt
touch sample1.fasta sample2.fasta sample3.fasta

# Update timestamp file yang sudah ada
touch existing_file.txt
```

---

## 2.5 Melihat Isi File

### `cat` — Concatenate (tampilkan isi file)
```bash
cat data/sequences.fasta
cat data/file1.txt data/file2.txt         # Gabungkan dan tampilkan
cat -n data/sequences.fasta          # Dengan nomor baris
```

### `head` & `tail`
```bash
# 10 baris pertama (default)
head data/sequences.fasta

# 5 baris pertama
head -5 data/sequences.fasta
head -n 5 data/sequences.fasta

# 10 baris terakhir
tail data/sequences.fasta

# 20 baris terakhir
tail -20 data/reads.fastq

# ⭐ Ikuti file yang sedang ditulis (untuk monitoring)
tail -f data/analysis.log
```

### `less` — Viewer interaktif (untuk file besar)
```bash
less data/large_file.fastq

# Navigasi di dalam less:
# ↑↓ atau j/k  → naik/turun baris
# Space / b     → halaman berikut/sebelumnya
# /pola         → cari teks
# n             → ke hasil pencarian berikutnya
# G             → ke baris terakhir
# g             → ke baris pertama
# q             → keluar
```

---

## 2.6 Wildcard (Karakter Pengganti)

Wildcard memungkinkan kamu bekerja dengan banyak file sekaligus:

```bash
# * = semua karakter apapun
ls *.fasta              # Semua file yang berakhir .fasta
ls sample*.fastq        # Semua file dimulai "sample", berakhir .fastq
cp *.fasta backup/      # Salin semua FASTA ke backup/

# ? = tepat satu karakter
ls sample?.fasta        # sample1.fasta, sampleA.fasta, tapi bukan sample10.fasta

# [] = salah satu karakter dari set
ls sample[123].fasta    # sample1.fasta, sample2.fasta, sample3.fasta
ls sample[A-Z].fasta    # sampleA.fasta sampai sampleZ.fasta

# Contoh bioinformatika:
ls *.fastq              # Semua file FASTQ
ls *_R1*.fastq.gz       # Semua file read 1 Illumina
ls chr[0-9]*.bed        # File BED untuk kromosom 1-9
```

---

## 2.7 Mencari File dengan `find`

Ketika proyek bioinformatika berkembang menjadi ratusan folder dan file, mencari file tertentu (misalnya, semua file FASTQ hasil sequencing) secara manual akan sangat melelahkan. Perintah `find` digunakan untuk melakukan pencarian berkas secara otomatis berdasarkan nama, tipe, ukuran, dan parameter lainnya.

### Sintaks Dasar:
```bash
find <path_pencarian> <kriteria> <pola>
```

### Contoh Penggunaan:
```bash
# 1. Mencari berdasarkan nama (name)
find . -name "*.fasta"              # Cari file .fasta di folder saat ini & subfoldernya
find . -iname "*bact*"              # Cari file yang mengandung kata "bact" (case-insensitive)

# 2. Mencari berdasarkan tipe (type: f = file, d = direktori)
find . -type d -name "data"         # Cari direktori bernama "data"
find . -type f -name "*.fastq"      # Cari file biasa yang berakhiran .fastq

# 3. Mencari berdasarkan ukuran (size)
find . -size +10M                   # Cari file yang lebih besar dari 10 Megabyte (+10M)
find . -size -1M                    # Cari file yang lebih kecil dari 1 Megabyte (-1M)

# 4. Mengombinasikan find dengan pipe
find . -type f -name "*.fastq" | wc -l  # Hitung jumlah file FASTQ di seluruh subfolder
```

---

## 🧬 Latihan: Setup Project Bioinformatika

```bash
# Buat struktur project untuk workshop ini
mkdir -p omicslite_workshop/{data/{raw,processed},results,scripts}

# Masuk ke project
cd omicslite_workshop

# Buat beberapa file dummy untuk latihan
touch data/raw/sample1.fastq data/raw/sample2.fastq
touch data/raw/genome.fasta
touch results/analysis_log.txt

# Lihat struktur
ls -R

# Cek ukuran direktori
du -sh */

# Hitung jumlah file
find . -type f | wc -l
```

---

## ✅ Checkpoint Modul 2

- [ ] `ls -lh` untuk melihat file dengan ukuran
- [ ] `cd`, `cd ..`, `cd ~` untuk navigasi
- [ ] Memahami absolute vs relative path
- [ ] `mkdir -p` untuk membuat direktori bersarang
- [ ] `cp`, `mv`, `rm` untuk manajemen file
- [ ] `head` dan `tail` untuk preview file
- [ ] `*` wildcard untuk banyak file
- [ ] Menggunakan `find` untuk mencari file berdasarkan kriteria (nama, tipe, ukuran)

---

**➡️ Lanjut ke:** [`../03-text-processing/README.md`](../03-text-processing/README.md)

---

*Modul 2 dari 5 | Workshop Bash for Biological Data Analysis — OmicsLite 2026*
