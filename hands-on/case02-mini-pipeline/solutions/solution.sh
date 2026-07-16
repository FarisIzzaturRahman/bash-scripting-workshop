#!/usr/bin/env bash
# ============================================================
# SOLUSI Case Study 2: Mini Bioinformatics Pipeline
# Workshop Bash for Biological Data Analysis — OmicsLite 2026
#
# ⚠️  SPOILER! Coba kerjakan sendiri dulu!
#
# Penggunaan: bash solution.sh [fastq_file] [bed_file]
# ============================================================

set -euo pipefail

# ============================================================
# KONFIGURASI
# ============================================================
# Temukan folder data relatif terhadap lokasi script ini,
# agar default path tetap valid dari mana pun script dijalankan.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ -f "$SCRIPT_DIR/../data/reads.fastq" ]]; then
    DATA_DIR="$SCRIPT_DIR/../data"     # dijalankan dari solutions/
else
    DATA_DIR="data"                    # dijalankan dari folder case study
fi

FASTQ="${1:-$DATA_DIR/reads.fastq}"
BED="${2:-$DATA_DIR/gene_regions.bed}"
PROJECT_DIR="my_analysis_project"
TIMESTAMP=$(date '+%Y%m%d_%H%M%S')
LOG_FILE="${PROJECT_DIR}/logs/pipeline_${TIMESTAMP}.log"

# ============================================================
# FUNGSI
# ============================================================

log() {
    local msg="[$(date '+%H:%M:%S')] $1"
    echo "$msg" | tee -a "$LOG_FILE"
}

log_section() {
    echo "" | tee -a "$LOG_FILE"
    echo "════════════════════════════════════════════════════" | tee -a "$LOG_FILE"
    echo "  $1" | tee -a "$LOG_FILE"
    echo "════════════════════════════════════════════════════" | tee -a "$LOG_FILE"
}

check_file() {
    local f="$1"
    if [ ! -f "$f" ]; then
        echo "ERROR: File tidak ditemukan: $f"
        exit 1
    fi
    if [ ! -s "$f" ]; then
        echo "ERROR: File kosong: $f"
        exit 1
    fi
}

# ============================================================
# TASK 1: SETUP PROJECT STRUCTURE
# ============================================================

echo "╔══════════════════════════════════════════════════════════╗"
echo "║   Mini Bioinformatics Pipeline v1.0                    ║"
echo "║   OmicsLite Workshop 2026                              ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""

echo "Step 1: Membuat project directory structure..."
mkdir -p "${PROJECT_DIR}/data/raw"
mkdir -p "${PROJECT_DIR}/data/processed"
mkdir -p "${PROJECT_DIR}/results/qc"
mkdir -p "${PROJECT_DIR}/results/stats"
mkdir -p "${PROJECT_DIR}/scripts"
mkdir -p "${PROJECT_DIR}/logs"

# Mulai logging setelah direktori dibuat
log "Pipeline dimulai."
log "Project directory: $PROJECT_DIR"
log "FASTQ input: $FASTQ"
log "BED input: $BED"

echo ""
echo "Struktur direktori yang dibuat:"
find "$PROJECT_DIR" -type d | sort | sed "s|$PROJECT_DIR|.|"

# Salin data ke project
log "Menyalin data ke project..."
cp "$FASTQ" "${PROJECT_DIR}/data/raw/"
cp "$BED" "${PROJECT_DIR}/data/raw/"
log "✅ Data tersalin."

# ============================================================
# TASK 2: VALIDASI INPUT
# ============================================================
log_section "TASK 2: VALIDASI INPUT"

log "Memvalidasi file input..."
check_file "$FASTQ"
check_file "$BED"
log "✅ Semua file input valid."

# ============================================================
# TASK 3: FASTQ QC ANALYSIS
# ============================================================
log_section "TASK 3: FASTQ QC ANALYSIS"

FASTQ_REPORT="${PROJECT_DIR}/results/qc/fastq_qc_report.txt"

log "Menganalisis file FASTQ: $FASTQ"

# Hitung jumlah reads
TOTAL_READS=$(grep -c "^@SRR" "$FASTQ" 2>/dev/null || grep -c "^@" "$FASTQ")
log "  Total reads: $TOTAL_READS"

# Ukuran file
FILE_SIZE=$(du -sh "$FASTQ" | cut -f1)

# Panjang reads
READ_LENGTHS=$(awk 'NR%4==2 {print length($0)}' "$FASTQ")
MIN_LEN=$(echo "$READ_LENGTHS" | sort -n | head -1)
MAX_LEN=$(echo "$READ_LENGTHS" | sort -n | tail -1)
AVG_LEN=$(echo "$READ_LENGTHS" | awk '{s+=$1; n++} END {printf "%.1f", s/n}')

# Hitung distribusi quality berdasarkan karakter dominan
HIGH_Q_READS=$(awk 'NR%4==0' "$FASTQ" | grep -c "IIIIIII" || true)
LOW_Q_READS=$(awk 'NR%4==0' "$FASTQ" | grep -c "!!!!!" || true)
MEDIUM_Q_READS=$((TOTAL_READS - HIGH_Q_READS - LOW_Q_READS))

# Simpan ke report
{
    echo "╔══════════════════════════════════════════╗"
    echo "║   FASTQ QC REPORT                       ║"
    echo "╚══════════════════════════════════════════╝"
    echo "Generated : $(date '+%Y-%m-%d %H:%M:%S')"
    echo "File      : $FASTQ"
    echo "File size : $FILE_SIZE"
    echo ""
    echo "── READ STATISTICS ──────────────────────"
    echo "Total reads    : $TOTAL_READS"
    echo "Min length     : $MIN_LEN bp"
    echo "Max length     : $MAX_LEN bp"
    echo "Avg length     : $AVG_LEN bp"
    echo ""
    echo "── QUALITY ASSESSMENT ───────────────────"
    echo "High quality reads (Q40 dominant) : $HIGH_Q_READS"
    echo "Low quality reads (!-dominant)    : $LOW_Q_READS"
    echo "Medium/mixed quality              : $MEDIUM_Q_READS"
    echo ""
    echo "── QUALITY STRINGS (per read) ───────────"
    awk 'NR%4==1 {name=$0} NR%4==0 {print name, "| QUAL:", $0}' "$FASTQ" | head -10
    echo "  ... (menampilkan 10 pertama)"
    echo ""
    echo "── KESIMPULAN ───────────────────────────"
    if [ "$LOW_Q_READS" -gt "$((TOTAL_READS / 4))" ]; then
        echo "⚠️  WARNING: Banyak reads berkualitas rendah!"
        echo "   Pertimbangkan quality trimming sebelum analisis."
    else
        echo "✅ Kualitas reads secara umum baik."
    fi
} > "$FASTQ_REPORT"

log "✅ FASTQ QC report tersimpan: $FASTQ_REPORT"

# ============================================================
# TASK 4: BED FILE ANALYSIS
# ============================================================
log_section "TASK 4: BED FILE ANALYSIS"

BED_REPORT="${PROJECT_DIR}/results/stats/bed_analysis_report.txt"

log "Menganalisis file BED: $BED"

# Statistik dasar
TOTAL_REGIONS=$(wc -l < "$BED")
TOTAL_CHROMS=$(cut -f 1 "$BED" | sort -u | wc -l)
PLUS_STRAND=$(awk '$6 == "+"' "$BED" | wc -l)
MINUS_STRAND=$(awk '$6 == "-"' "$BED" | wc -l)

# Statistik panjang
read MIN_LEN_BED MAX_LEN_BED AVG_LEN_BED TOTAL_COV <<< $(awk '{
    len=$3-$2; sum+=len; n++;
    if(len>max||n==1) max=len;
    if(len<min||n==1) min=len
} END {print min, max, int(sum/n), sum}' "$BED")

# Simpan ke report
{
    echo "╔══════════════════════════════════════════╗"
    echo "║   BED FILE ANALYSIS REPORT              ║"
    echo "╚══════════════════════════════════════════╝"
    echo "Generated : $(date '+%Y-%m-%d %H:%M:%S')"
    echo "File      : $BED"
    echo ""
    echo "── REGION STATISTICS ─────────────────────"
    echo "Total regions     : $TOTAL_REGIONS"
    echo "Total chromosomes : $TOTAL_CHROMS"
    echo "Strand + (plus)   : $PLUS_STRAND"
    echo "Strand - (minus)  : $MINUS_STRAND"
    echo ""
    echo "── LENGTH STATISTICS ─────────────────────"
    echo "Min region length : $MIN_LEN_BED bp"
    echo "Max region length : $MAX_LEN_BED bp"
    echo "Avg region length : $AVG_LEN_BED bp"
    echo "Total coverage    : $TOTAL_COV bp"
    echo ""
    echo "── DISTRIBUSI PER KROMOSOM ───────────────"
    printf "%-10s %-10s %-15s\n" "Kromosom" "Jumlah" "Coverage (bp)"
    printf "%-10s %-10s %-15s\n" "--------" "------" "------------"
    awk '{print $1, $3-$2}' "$BED" | \
        awk '{chr[$1]+=$2; n[$1]++} END {for(c in chr) print n[c], chr[c], c}' | \
        sort -rn | \
        awk '{printf "%-10s %-10s %-15s\n", $3, $1, $2}'
    echo ""
    echo "── TOP 5 GENE TERPANJANG ─────────────────"
    awk '{print $3-$2, $4}' "$BED" | sort -rn | head -5 | \
        awk '{printf "  %-30s %s bp\n", $2, $1}'
    echo ""
    echo "── TOP 5 GENE TERPENDEK ──────────────────"
    awk '{print $3-$2, $4}' "$BED" | sort -n | head -5 | \
        awk '{printf "  %-30s %s bp\n", $2, $1}'
} > "$BED_REPORT"

log "✅ BED analysis report tersimpan: $BED_REPORT"

# ============================================================
# TASK 5: SUMMARY REPORT
# ============================================================
log_section "TASK 5: SUMMARY REPORT"

SUMMARY="${PROJECT_DIR}/results/pipeline_summary.txt"

{
    echo "╔════════════════════════════════════════════════════╗"
    echo "║   PIPELINE SUMMARY REPORT                         ║"
    echo "║   Mini Bioinformatics Pipeline — OmicsLite 2026   ║"
    echo "╚════════════════════════════════════════════════════╝"
    echo ""
    echo "Run date  : $(date '+%Y-%m-%d %H:%M:%S')"
    echo "Run by    : $(whoami)"
    echo ""
    echo "── INPUT FILES ──────────────────────────────────────"
    echo "FASTQ     : $FASTQ ($(du -sh "$FASTQ" | cut -f1))"
    echo "BED       : $BED ($(du -sh "$BED" | cut -f1))"
    echo ""
    echo "── FASTQ SUMMARY ────────────────────────────────────"
    echo "Total reads         : $TOTAL_READS"
    echo "Read length range   : ${MIN_LEN}-${MAX_LEN} bp (avg: ${AVG_LEN} bp)"
    echo "High quality reads  : $HIGH_Q_READS"
    echo ""
    echo "── BED SUMMARY ──────────────────────────────────────"
    echo "Total regions       : $TOTAL_REGIONS"
    echo "Chromosomes covered : $TOTAL_CHROMS"
    echo "Total coverage      : $TOTAL_COV bp"
    echo "Avg region length   : $AVG_LEN_BED bp"
    echo ""
    echo "── OUTPUT FILES ─────────────────────────────────────"
    echo "QC Report   : $FASTQ_REPORT"
    echo "BED Report  : $BED_REPORT"
    echo "Log file    : $LOG_FILE"
    echo ""
    echo "── STATUS ───────────────────────────────────────────"
    echo "✅ Pipeline selesai tanpa error!"
} > "$SUMMARY"

log "✅ Summary report tersimpan: $SUMMARY"

# ============================================================
# SELESAI
# ============================================================
log_section "PIPELINE SELESAI"

log "Semua hasil tersimpan di: $PROJECT_DIR/results/"
log "Log tersimpan di: $LOG_FILE"

echo ""
echo "Hasil pipeline:"
find "${PROJECT_DIR}/results" -type f | while read -r f; do
    echo "  📄 $f ($(du -sh "$f" | cut -f1))"
done
echo ""

echo "╔══════════════════════════════════════════════════════════╗"
echo "║   ✅ Case Study 2 Selesai! Pipeline berjalan sukses!   ║"
echo "╚══════════════════════════════════════════════════════════╝"
