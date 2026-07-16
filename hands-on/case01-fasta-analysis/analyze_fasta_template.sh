#!/usr/bin/env bash
# ============================================================
# TEMPLATE: Analisis File FASTA
# Workshop Bash for Biological Data Analysis — OmicsLite 2026
#
# Petunjuk: Isi bagian # TODO dengan perintah Bash yang sesuai.
# Jalankan dengan: bash analyze_fasta_template.sh data/sequences.fasta
# ============================================================

set -euo pipefail

# Memastikan argumen file input diberikan
if [ "$#" -ne 1 ]; then
    echo "Penggunaan: $0 <file.fasta>"
    exit 1
fi

INPUT="$1"

# Memastikan file input ada
if [ ! -f "$INPUT" ]; then
    echo "ERROR: File '$INPUT' tidak ditemukan!"
    exit 1
fi

echo "========================================"
echo "Menganalisis file : $INPUT"
# TODO 1: Tampilkan ukuran file menggunakan perintah du -sh (ambil kolom pertama saja)
# UBAH baris di bawah ini:
FILE_SIZE="??"
echo "Ukuran file       : $FILE_SIZE"
echo "========================================"

# TODO 2: Hitung jumlah total sekuens (petunjuk: hitung baris yang dimulai dengan '>')
# UBAH baris di bawah ini:
SEQ_COUNT=0
echo "Total sekuens     : $SEQ_COUNT"

# TODO 3: Hitung total nukleotida (petunjuk: ambil baris bukan header, hapus spasi/newline, lalu hitung karakter)
# UBAH baris di bawah ini:
TOTAL_NT=0
echo "Total nukleotida  : $TOTAL_NT bp"

# TODO 4: Hitung jumlah basa G dan C saja untuk menghitung GC Content
# UBAH baris di bawah ini:
GC_COUNT=0

# Menghitung persentase GC Content menggunakan utilitas bc (sudah disediakan)
if [ "$TOTAL_NT" -gt 0 ]; then
    GC_PERCENT=$(echo "scale=2; $GC_COUNT * 100 / $TOTAL_NT" | bc)
    echo "GC Content        : $GC_PERCENT%"
else
    echo "GC Content        : N/A (Sekuens kosong)"
fi

echo "----------------------------------------"
echo "Daftar organisme unik di dalam file:"
# TODO 5: Ekstrak organisme dari header (kolom ke-2, dipisahkan oleh karakter '|') lalu urutkan secara unik
# TULIS perintah Anda di bawah ini (ingat untuk menyaring baris header '^>' terlebih dahulu):

echo "========================================"
echo "Selesai!"
