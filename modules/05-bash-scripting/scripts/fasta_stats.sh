#!/usr/bin/env bash
# ============================================================
# Script  : fasta_stats.sh
# Workshop: Bash for Biological Data Analysis — OmicsLite 2026
# Deskripsi: Menghitung statistik dari file FASTA
# Penggunaan: bash fasta_stats.sh <input.fasta> [output.txt]
# Contoh  : bash fasta_stats.sh sequences.fasta hasil_analisis.txt
# ============================================================

set -euo pipefail  # Exit on error, unset variables, pipe failures

# ============================================================
# FUNGSI-FUNGSI
# ============================================================

# Cetak header banner
print_banner() {
    echo "╔════════════════════════════════════════════════╗"
    echo "║     FASTA Statistics Analyzer v1.0            ║"
    echo "║     OmicsLite Workshop 2026                   ║"
    echo "╚════════════════════════════════════════════════╝"
    echo ""
}

# Cetak cara penggunaan
usage() {
    echo "Penggunaan : $0 <input.fasta> [output.txt]"
    echo ""
    echo "Argumen:"
    echo "  input.fasta   File FASTA yang akan dianalisis (wajib)"
    echo "  output.txt    File output (opsional; default: ke layar)"
    echo ""
    echo "Contoh:"
    echo "  $0 sequences.fasta"
    echo "  $0 sequences.fasta stats_result.txt"
    exit 1
}

# Hitung GC content untuk satu sequence (input: string sequence)
calc_gc() {
    local seq="$1"
    local total=${#seq}
    if [ "$total" -eq 0 ]; then
        echo "0.00"
        return
    fi
    local gc
    gc=$(echo "$seq" | tr -cd 'GCgc' | wc -c)
    echo "scale=2; $gc * 100 / $total" | bc
}

# ============================================================
# VALIDASI INPUT
# ============================================================

# Cek apakah argumen diberikan
if [ "$#" -lt 1 ]; then
    print_banner
    echo "ERROR: Harap berikan file FASTA sebagai argumen!"
    echo ""
    usage
fi

INPUT_FILE="$1"
OUTPUT_FILE="${2:-}"  # Argumen kedua opsional

# Cek apakah file ada
if [ ! -f "$INPUT_FILE" ]; then
    echo "ERROR: File '$INPUT_FILE' tidak ditemukan!"
    exit 1
fi

# Cek apakah file tidak kosong
if [ ! -s "$INPUT_FILE" ]; then
    echo "ERROR: File '$INPUT_FILE' kosong!"
    exit 1
fi

# ============================================================
# ANALISIS UTAMA
# ============================================================

print_banner

echo "═══ INFORMASI FILE ══════════════════════════════"
echo "  File     : $INPUT_FILE"
echo "  Ukuran   : $(du -sh "$INPUT_FILE" | cut -f1)"
echo "  Diproses : $(date '+%Y-%m-%d %H:%M:%S')"
echo ""

# --- Hitung jumlah sequence ---
SEQ_COUNT=$(grep -c "^>" "$INPUT_FILE")
echo "═══ STATISTIK SEQUENCE ══════════════════════════"
echo "  Jumlah sequence : $SEQ_COUNT"

# --- Ambil sequence saja (tanpa header) ---
SEQUENCES_ONLY=$(grep -v "^>" "$INPUT_FILE" | tr -d '\n ')

# --- Total panjang ---
TOTAL_NT=${#SEQUENCES_ONLY}
echo "  Total nukleotida: $TOTAL_NT bp"

# --- Rata-rata panjang ---
if [ "$SEQ_COUNT" -gt 0 ]; then
    AVG_LEN=$(echo "scale=1; $TOTAL_NT / $SEQ_COUNT" | bc)
    echo "  Rata-rata panjang: $AVG_LEN bp"
fi

# --- GC content keseluruhan ---
GC_TOTAL=$(echo "$SEQUENCES_ONLY" | tr -cd 'GCgc' | wc -c)
AT_TOTAL=$(echo "$SEQUENCES_ONLY" | tr -cd 'ATat' | wc -c)

if [ "$TOTAL_NT" -gt 0 ]; then
    GC_PERCENT=$(echo "scale=2; $GC_TOTAL * 100 / $TOTAL_NT" | bc)
    echo "  GC content (total): $GC_PERCENT%"
fi

echo ""

# --- Analisis per sequence ---
echo "═══ ANALISIS PER SEQUENCE ═══════════════════════"
printf "%-10s %-50s %-8s %-8s\n" "No." "Header (dipotong)" "Panjang" "GC(%)"
printf "%-10s %-50s %-8s %-8s\n" "----" "--------------------------------------------------" "-------" "------"

SEQ_NUM=0
CURRENT_HEADER=""
CURRENT_SEQ=""
MAX_LEN=0
MIN_LEN=999999999

while IFS= read -r line; do
    if [[ "$line" == ">"* ]]; then
        # Proses sequence sebelumnya jika ada
        if [ -n "$CURRENT_SEQ" ]; then
            SEQ_NUM=$((SEQ_NUM + 1))
            SEQ_LEN=${#CURRENT_SEQ}
            GC_PCT=$(calc_gc "$CURRENT_SEQ")

            # Potong header jika terlalu panjang
            SHORT_HEADER="${CURRENT_HEADER:0:48}"
            printf "%-10s %-50s %-8s %-8s\n" "$SEQ_NUM" "$SHORT_HEADER" "${SEQ_LEN}" "$GC_PCT"

            # Update min/max
            if [ "$SEQ_LEN" -gt "$MAX_LEN" ]; then
                MAX_LEN=$SEQ_LEN
                MAX_HEADER="$CURRENT_HEADER"
            fi
            if [ "$SEQ_LEN" -lt "$MIN_LEN" ]; then
                MIN_LEN=$SEQ_LEN
                MIN_HEADER="$CURRENT_HEADER"
            fi
        fi
        # Mulai sequence baru
        CURRENT_HEADER="${line#>}"
        CURRENT_SEQ=""
    else
        # Tambahkan ke sequence saat ini
        CURRENT_SEQ+="$line"
    fi
done < "$INPUT_FILE"

# Proses sequence terakhir
if [ -n "$CURRENT_SEQ" ]; then
    SEQ_NUM=$((SEQ_NUM + 1))
    SEQ_LEN=${#CURRENT_SEQ}
    GC_PCT=$(calc_gc "$CURRENT_SEQ")
    SHORT_HEADER="${CURRENT_HEADER:0:48}"
    printf "%-10s %-50s %-8s %-8s\n" "$SEQ_NUM" "$SHORT_HEADER" "${SEQ_LEN}" "$GC_PCT"

    if [ "$SEQ_LEN" -gt "$MAX_LEN" ]; then
        MAX_LEN=$SEQ_LEN
        MAX_HEADER="$CURRENT_HEADER"
    fi
    if [ "$SEQ_LEN" -lt "$MIN_LEN" ]; then
        MIN_LEN=$SEQ_LEN
        MIN_HEADER="$CURRENT_HEADER"
    fi
fi

echo ""
echo "═══ RINGKASAN ═══════════════════════════════════"
echo "  Sequence terpanjang : $MAX_LEN bp"
echo "    → $MAX_HEADER"
echo "  Sequence terpendek  : $MIN_LEN bp"
echo "    → $MIN_HEADER"
echo ""

# ============================================================
# SIMPAN KE FILE (OPSIONAL)
# ============================================================

if [ -n "$OUTPUT_FILE" ]; then
    # Jalankan ulang analisis dan simpan ke file
    {
        echo "FASTA Statistics Report"
        echo "File: $INPUT_FILE"
        echo "Date: $(date)"
        echo "Total sequences: $SEQ_COUNT"
        echo "Total nucleotides: $TOTAL_NT"
        echo "Average length: $AVG_LEN bp"
        echo "GC content: $GC_PERCENT%"
    } > "$OUTPUT_FILE"
    echo "  💾 Hasil tersimpan di: $OUTPUT_FILE"
fi

echo "✅ Analisis selesai!"
echo "════════════════════════════════════════════════"
