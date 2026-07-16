# 📜 Modul 5 — Pengantar Bash Scripting

> **Durasi:** Referensi tambahan (dipelajari mandiri atau setelah workshop)
>
> *"Script bash yang baik adalah analisis yang bisa diulang kapan saja."*

---

## 5.1 Apa itu Bash Script?

Bash script adalah **file teks yang berisi sekumpulan perintah bash** yang dijalankan berurutan. Bayangkan kamu mengetik 20 perintah di terminal — daripada ketik ulang setiap kali, simpan dalam satu file dan jalankan sekali!

### Mengapa menulis script?
- ♻️ **Reproducible**: Analisis bisa diulang dengan hasil sama
- ⚡ **Efisien**: Jalankan 100 file sekaligus
- 📋 **Dokumentasi**: Script = dokumentasi analisis kamu
- 🤖 **Otomasi**: Jalankan di malam hari tanpa dijaga

---

## 5.2 Membuat Script Pertama

### Langkah 1: Buat file baru
```bash
nano hello_bio.sh
# atau
vim hello_bio.sh
# atau
touch hello_bio.sh && code hello_bio.sh  # VS Code
```

### Langkah 2: Tulis script
```bash
#!/usr/bin/env bash
# ============================================================
# Script: hello_bio.sh
# Deskripsi: Script bash pertama untuk bioinformatika
# Author: [Nama kamu]
# Date: 2026-07-18
# ============================================================

echo "========================================"
echo "  Selamat datang di Dunia Bioinformatika!"
echo "========================================"
echo ""
echo "Tanggal    : $(date '+%Y-%m-%d %H:%M:%S')"
echo "Pengguna   : $(whoami)"
echo "Direktori  : $(pwd)"
echo "Bash versi : $(bash --version | head -1)"
echo ""
echo "Script pertamamu berhasil dijalankan! 🧬"
```

### Langkah 3: Beri permission (izin eksekusi)
```bash
chmod +x hello_bio.sh
```

### Langkah 4: Jalankan!
```bash
bash hello_bio.sh
# atau (jika sudah chmod +x):
./hello_bio.sh
```

---

## 5.3 Shebang Line

```bash
#!/usr/bin/env bash
```

- Baris pertama script = **shebang** (dibaca sebagai `#!` "hash-bang")
- Memberitahu sistem: "Gunakan program `bash` untuk menjalankan script ini"
- `#!/usr/bin/env bash` lebih portable daripada `#!/bin/bash`
- Selalu sertakan shebang di setiap script!

---

## 5.4 Variabel

```bash
#!/usr/bin/env bash

# Definisi variabel (TIDAK ada spasi di sekitar =)
SAMPLE_NAME="SRR123456"
INPUT_FILE="data/reads.fastq"
THREADS=8
MIN_QUALITY=30

# Gunakan variabel dengan $
echo "Memproses sample: $SAMPLE_NAME"
echo "File input: $INPUT_FILE"
echo "Threads: $THREADS"

# Variabel dari output perintah (command substitution)
CURRENT_DATE=$(date '+%Y%m%d')
READ_COUNT=$(grep -c "^@" $INPUT_FILE)
FILE_SIZE=$(du -sh $INPUT_FILE | cut -f1)

echo "Tanggal: $CURRENT_DATE"
echo "Jumlah reads: $READ_COUNT"
echo "Ukuran file: $FILE_SIZE"

# String concatenation
OUTPUT_FILE="${SAMPLE_NAME}_processed_${CURRENT_DATE}.fastq"
echo "Output akan disimpan di: $OUTPUT_FILE"
```



---

## 5.5 Argumen Baris Perintah

```bash
#!/usr/bin/env bash
# Penggunaan: bash script.sh input.fasta output.txt

# $1, $2, dst = argumen yang diberikan saat menjalankan script
INPUT="$1"
OUTPUT="$2"

echo "Input  : $INPUT"
echo "Output : $OUTPUT"

# Cek apakah argumen diberikan
if [ -z "$INPUT" ]; then
    echo "ERROR: Harap berikan file input!"
    echo "Penggunaan: $0 <input.fasta> <output.txt>"
    exit 1
fi

# Cek apakah file exist
if [ ! -f "$INPUT" ]; then
    echo "ERROR: File $INPUT tidak ditemukan!"
    exit 1
fi

# Proses file...
grep -c "^>" "$INPUT" > "$OUTPUT"
echo "Selesai! Hasil disimpan di $OUTPUT"
```

Cara menjalankan:
```bash
bash script.sh sequences.fasta hasil.txt
```

---

## 5.6 Variabel Spesial & Exit Code

Bash menyediakan beberapa variabel bawaan khusus yang sangat berguna untuk mendeteksi status jalannya perintah dan parameter:

| Variabel | Fungsi |
|----------|--------|
| `$0` | Nama script bash itu sendiri (misalnya: `script.sh`) |
| `$1`, `$2`, dst. | Argumen/parameter ke-1, ke-2, dst. yang diberikan saat menjalankan script |
| `$#` | Jumlah total argumen yang dimasukkan ke dalam script |
| `$@` | Seluruh daftar argumen yang diberikan (sebagai array/list) |
| `$?` | **Exit Status/Exit Code** dari perintah terakhir yang dieksekusi |

### Memahami Exit Status (`$?`)
Setiap kali sebuah perintah selesai dijalankan di terminal Linux, perintah tersebut akan secara otomatis mengembalikan kode status berupa angka:
*   `0`: Sukses (tidak terjadi kesalahan/error).
*   `1` s.d. `255`: Gagal (terdapat error teknis atau kondisi tidak terpenuhi).

*Contoh mendeteksi keberhasilan perintah:*
```bash
# Menjalankan pencarian motif DNA
grep "GAATTC" data/gene_A.fasta

# Memeriksa status pencarian (0 jika motif ditemukan, 1 jika tidak ditemukan)
echo "Status pencarian: $?"

# Contoh penanganan error manual:
mkdir -p results/
if [ $? -ne 0 ]; then
    echo "ERROR: Gagal membuat direktori results/"
    exit 1
fi
```

---

## 5.7 Kondisi (If-Else)

```bash
#!/usr/bin/env bash

FILE="sequences.fasta"

# Cek apakah file ada
if [ -f "$FILE" ]; then
    echo "File $FILE ditemukan ✅"
else
    echo "File $FILE tidak ditemukan ❌"
fi

# Cek apakah direktori ada
if [ -d "results/" ]; then
    echo "Direktori results/ sudah ada"
else
    echo "Membuat direktori results/..."
    mkdir -p results/
fi

# Perbandingan angka
READ_COUNT=$(grep -c "^@" reads.fastq)
if [ "$READ_COUNT" -gt 1000000 ]; then
    echo "WARNING: File besar ($READ_COUNT reads). Mungkin butuh waktu lama."
elif [ "$READ_COUNT" -gt 100000 ]; then
    echo "File medium ($READ_COUNT reads)."
else
    echo "File kecil ($READ_COUNT reads). Proses cepat."
fi
```

### Operator kondisi yang sering digunakan:
```bash
# File/direktori
-f "$FILE"    # File ada?
-d "$DIR"     # Direktori ada?
-s "$FILE"    # File ada dan tidak kosong?
-r "$FILE"    # File bisa dibaca?

# String
-z "$VAR"     # String kosong/empty?
-n "$VAR"     # String tidak kosong?
"$a" == "$b"  # String sama?
"$a" != "$b"  # String berbeda?

# Angka
-eq           # equal (sama dengan)
-ne           # not equal (tidak sama)
-gt           # greater than (lebih besar)
-lt           # less than (lebih kecil)
-ge           # greater or equal
-le           # less or equal
```

---

## 5.8 Loop — For

```bash
#!/usr/bin/env bash

# Loop sederhana
for i in 1 2 3 4 5; do
    echo "Iterasi ke-$i"
done

# Loop atas range angka
for i in $(seq 1 10); do
    echo "Sample $i"
done

# ⭐ Loop paling berguna: iterasi atas file
for file in data/*.fasta; do
    echo "Memproses: $file"
    grep -c "^>" "$file"
done

# Loop atas banyak sample (sangat umum di bioinformatika!)
SAMPLES=("SRR123456" "SRR123457" "SRR123458" "SRR123459")
for sample in "${SAMPLES[@]}"; do
    echo "=== Memproses $sample ==="
    echo "  Hitung reads: $(grep -c '^@' data/${sample}.fastq)"
    echo "  Selesai!"
done

# Loop dengan index
for i in "${!SAMPLES[@]}"; do
    echo "Sample ${i}: ${SAMPLES[$i]}"
done

# 🧬 Pola Terpenting: Looping File Berpasangan (Paired-End Reads)
# Dalam Illumina sequencing, data yang didapatkan terdiri atas pasangan forward (R1) dan reverse (R2).
# Kita bisa memproses kedua file berpasangan ini sekaligus dengan memanfaatkan substitusi variabel Bash:

for r1 in data/*_R1.fastq.gz; do
    # Trik: ganti "_R1" menjadi "_R2" untuk mendapatkan nama file pasangannya
    r2="${r1/_R1.fastq.gz/_R2.fastq.gz}"
    
    # Ambil nama sample bersih (menghapus path folder dan ekstensi)
    sample_name=$(basename "$r1" _R1.fastq.gz)
    
    echo "Memproses pasangan sample: $sample_name"
    echo "  Forward reads (R1): $r1"
    echo "  Reverse reads (R2): $r2"
    
    # Contoh perintah tool analisis:
    # fastp -i "$r1" -I "$r2" -o "clean_${sample_name}_R1.fq.gz" -O "clean_${sample_name}_R2.fq.gz"
done
```

---

## 5.9 Script Lengkap: Analisis Multi-FASTA

Lihat script lengkap di [`scripts/fasta_stats.sh`](scripts/fasta_stats.sh)

```bash
#!/usr/bin/env bash
# ============================================================
# fasta_stats.sh — Analisis statistik file FASTA
# Penggunaan: bash fasta_stats.sh <input.fasta>
# ============================================================

set -euo pipefail  # Exit on error, undefined vars, pipe failures

# ---- Fungsi ----
print_header() {
    echo "========================================"
    echo "  FASTA Statistics Analyzer"
    echo "  OmicsLite Workshop 2026"
    echo "========================================"
}

usage() {
    echo "Penggunaan: $0 <input.fasta>"
    echo "Contoh:    $0 sequences.fasta"
    exit 1
}

# ---- Validasi input ----
if [ "$#" -ne 1 ]; then
    usage
fi

INPUT="$1"

if [ ! -f "$INPUT" ]; then
    echo "ERROR: File '$INPUT' tidak ditemukan!"
    exit 1
fi

# ---- Analisis ----
print_header
echo ""
echo "File       : $INPUT"
echo "Ukuran     : $(du -sh "$INPUT" | cut -f1)"
echo ""

# Hitung jumlah sequence
SEQ_COUNT=$(grep -c "^>" "$INPUT")
echo "Jumlah sequence : $SEQ_COUNT"

# Total panjang nukleotida
TOTAL_NT=$(grep -v "^>" "$INPUT" | tr -d '\n ' | wc -c)
echo "Total nukleotida: $TOTAL_NT"

# GC content
GC_COUNT=$(grep -v "^>" "$INPUT" | tr -cd 'GCgc' | wc -c)
GC_PERCENT=$(echo "scale=2; $GC_COUNT * 100 / $TOTAL_NT" | bc)
echo "GC content      : $GC_PERCENT%"

# Rata-rata panjang
AVG=$(echo "scale=1; $TOTAL_NT / $SEQ_COUNT" | bc)
echo "Avg panjang seq : $AVG bp"

echo ""
echo "--- Header sequences ---"
grep "^>" "$INPUT"

echo ""
echo "✅ Analisis selesai!"
```

---

## 5.10 Tips Best Practice Script

```bash
#!/usr/bin/env bash

# 1. Selalu gunakan set -euo pipefail di awal untuk mode aman
set -euo pipefail

# 💡 Arti dari set -euo pipefail:
# - '-e': Menghentikan script jika ada perintah yang gagal (exit code bukan 0).
# - '-u': Menghentikan script jika memanggil variabel yang belum didefinisikan (no unset).
# - '-o pipefail': Memastikan error di dalam pipe (|) tetap terdeteksi sebagai kegagalan script.

# 2. Definisikan variabel di atas
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DATE=$(date '+%Y%m%d_%H%M%S')
LOG_FILE="logs/analysis_${DATE}.log"

# 3. Gunakan fungsi untuk organisasi kode
log() {
    echo "[$(date '+%H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# 4. Buat direktori output di awal
mkdir -p results/ logs/

# 5. Log setiap langkah penting
log "Memulai analisis..."
log "Input: $1"

# 6. Beri exit code yang jelas
# 0 = sukses, 1 = error umum
exit 0
```

---

## ✅ Checkpoint Modul 5

- [ ] Membuat dan menjalankan bash script
- [ ] Memahami shebang line (`#!/usr/bin/env bash`)
- [ ] Menggunakan variabel dan command substitution
- [ ] Menerima argumen dari command line
- [ ] Memahami Exit Status/Exit Code (`$?`) dan kegunaannya untuk deteksi error
- [ ] Menggunakan kondisi if-else
- [ ] Membuat loop untuk memproses banyak file
- [ ] Memahami pola loop file berpasangan (*paired-end reads*) menggunakan substitusi variabel Bash
- [ ] Menerapkan mode pengaman `set -euo pipefail` pada script
- [ ] Menulis script yang terdokumentasi dengan baik

---

**➡️ Lanjut ke:** [`../../hands-on/README.md`](../../hands-on/README.md)

---

*Modul 5 dari 5 | Workshop Bash for Biological Data Analysis — OmicsLite 2026*
