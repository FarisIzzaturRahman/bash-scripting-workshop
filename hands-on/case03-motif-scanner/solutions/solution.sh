#!/usr/bin/env bash
# ============================================================
# SOLUSI: Restriction Enzyme / DNA Motif Scanner
# Workshop Bash for Biological Data Analysis — OmicsLite 2026
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
echo "Target Motif: $MOTIF (panjang: ${#MOTIF} bp)"
echo "----------------------------------------"

# 1. Bersihkan file FASTA agar hanya menyisakan sekuens dalam satu baris tanpa header
# Kita konversi semua sekuens menjadi satu string tanpa spasi atau baris baru
SEQ_CLEANED=$(grep -v "^>" "$INPUT_FASTA" | tr -d '\n\r ')

# 2. Cari motif menggunakan grep dengan flag -o (only-matching) dan -b (byte-offset)
# Kita gunakan opsi -i agar pencarian bersifat case-insensitive
# '|| true' digunakan agar script tidak crash jika tidak ada motif yang cocok (set -e aktif)
MATCHES=$(echo "$SEQ_CLEANED" | grep -o -b -i "$MOTIF" || true)

if [ -z "$MATCHES" ]; then
    echo "Hasil: Tidak ditemukan situs pemotongan untuk motif: $MOTIF"
    echo "========================================"
    exit 0
fi

# 3. Hitung jumlah kecocokan
COUNT=$(echo "$MATCHES" | wc -l)
echo "Total situs pemotongan: $COUNT"
echo ""
echo "Lokasi pemotongan (Posisi Basa):"
echo "----------------------------------------"

# 4. Tampilkan koordinat pemotongan
# Format output dari grep -b adalah "offset:motif" (contoh: "180:GAATTC")
echo "$MATCHES" | while read -r line; do
    OFFSET=$(echo "$line" | cut -d':' -f1)
    # Ubah dari 0-based index menjadi 1-based index (posisi basa biologis)
    BASE_POS=$((OFFSET + 1))
    echo "-> Terdeteksi pada basa ke-$BASE_POS"
done

echo "========================================"
