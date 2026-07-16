#!/usr/bin/env bash
# ============================================================
# TEMPLATE: DNA Motif Scanner (Bonus Challenge)
# Workshop Bash for Biological Data Analysis — OmicsLite 2026
#
# Petunjuk: Lengkapi bagian # TODO di dalam script ini.
# Jalankan dengan: bash scan_motif_template.sh data/lambda_virus.fasta GAATTC
# ============================================================

set -euo pipefail

# Validasi input argumen
if [ "$#" -lt 2 ]; then
    echo "Penggunaan: $0 <file.fasta> <motif_sequence>"
    exit 1
fi

INPUT_FASTA="$1"
MOTIF="$2"

# Validasi keberadaan file
if [ ! -f "$INPUT_FASTA" ]; then
    echo "ERROR: File '$INPUT_FASTA' tidak ditemukan!"
    exit 1
fi

echo "========================================"
echo "      RESTRICTION ENZYME SCANNER        "
echo "========================================"
echo "File FASTA  : $INPUT_FASTA"
echo "Target Motif: $MOTIF"
echo "----------------------------------------"

# TODO 1: Bersihkan file FASTA agar hanya menyisakan sekuens dalam satu baris (tanpa header '>', spasi, atau newline)
# Gunakan grep -v, tr -d, dan simpan hasilnya di variabel SEQ_CLEANED
# UBAH baris di bawah ini:
SEQ_CLEANED=""

# TODO 2: Gunakan grep dengan flag -o dan -b untuk mencari koordinat kecocokan motif secara case-insensitive (-i)
# Gunakan pipa (pipeline) dari variabel SEQ_CLEANED ke grep
# Tambahkan '|| true' di akhir perintah agar script tidak langsung keluar (crash) jika tidak ada kecocokan.
# UBAH baris di bawah ini:
MATCHES=""

# Validasi jika hasil pencarian kosong (sudah disediakan)
if [ -z "$MATCHES" ]; then
    echo "Hasil: Tidak ditemukan situs pemotongan untuk motif: $MOTIF"
    echo "========================================"
    exit 0
fi

# TODO 3: Hitung jumlah total situs pemotongan (hitung jumlah baris pada variabel MATCHES menggunakan wc -l)
# UBAH baris di bawah ini:
COUNT=0
echo "Total situs pemotongan: $COUNT"
echo ""
echo "Lokasi pemotongan (Posisi Basa):"
echo "----------------------------------------"

# TODO 4: Loop setiap baris kecocokan untuk menampilkan posisi basanya
# (Variabel MATCHES memiliki format "offset:motif" per baris. Gunakan cut untuk mengambil kolom offset)
echo "$MATCHES" | while read -r line; do
    # Tulis perintah cut untuk mengambil nilai offset di sini (kolom 1 dengan separator ':'):
    OFFSET=0
    
    # Ubah koordinat 0-based index menjadi 1-based index (posisi basa biologis)
    BASE_POS=$((OFFSET + 1))
    echo "-> Terdeteksi pada basa ke-$BASE_POS"
done

echo "========================================"
