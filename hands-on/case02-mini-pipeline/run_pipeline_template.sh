#!/usr/bin/env bash
# ============================================================
# TEMPLATE: Mini Bioinformatics Pipeline
# Workshop Bash for Biological Data Analysis — OmicsLite 2026
#
# Petunjuk: Lengkapi bagian # TODO di dalam script ini.
# Jalankan dengan: bash run_pipeline_template.sh data/reads.fastq data/gene_regions.bed
# ============================================================

set -euo pipefail

# 1. KONFIGURASI
FASTQ="${1:-data/reads.fastq}"
BED="${2:-data/gene_regions.bed}"
PROJECT_DIR="my_analysis_project"
LOG_FILE="${PROJECT_DIR}/logs/pipeline.log"

# Fungsi helper untuk logging (sudah disediakan)
log() {
    local msg="[$(date '+%H:%M:%S')] $1"
    echo "$msg" | tee -a "$LOG_FILE"
}

echo "╔══════════════════════════════════════════════════════════╗"
echo "║   Mini Bioinformatics Pipeline (Template)                ║"
echo "║   OmicsLite Workshop 2026                                ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""

# ============================================================
# TASK 1: SETUP PROJECT STRUCTURE
# ============================================================
echo "Step 1: Membuat project directory structure..."

# TODO 1: Buat folder project structure menggunakan mkdir -p
# Folder yang dibutuhkan:
# - ${PROJECT_DIR}/data/raw
# - ${PROJECT_DIR}/data/processed
# - ${PROJECT_DIR}/results/qc
# - ${PROJECT_DIR}/results/stats
# - ${PROJECT_DIR}/scripts
# - ${PROJECT_DIR}/logs
# TULIS perintah mkdir Anda di bawah ini:


# Mulai logging setelah direktori dibuat (memastikan folder logs/ ada)
log "Pipeline dimulai."

# TODO 2: Salin file input $FASTQ dan $BED ke folder ${PROJECT_DIR}/data/raw/
# TULIS perintah cp Anda di bawah ini:


log "✅ Struktur folder siap dan file disalin."

# ============================================================
# TASK 2: FASTQ QC ANALYSIS
# ============================================================
log "Step 2: Menganalisis file FASTQ..."
FASTQ_REPORT="${PROJECT_DIR}/results/qc/fastq_qc_report.txt"

# TODO 3: Hitung total reads (FASTQ memiliki 4 baris per read, gunakan wc -l dan pembagian)
# UBAH baris di bawah ini:
TOTAL_READS=0

# TODO 4: Hitung ukuran file input FASTQ menggunakan du -sh (ambil kolom pertama saja)
# UBAH baris di bawah ini:
FILE_SIZE="??"

# Log progress
log "  Total reads : $TOTAL_READS"
log "  Ukuran file : $FILE_SIZE"

# Menghitung panjang reads (sudah disediakan)
READ_LENGTHS=$(awk 'NR%4==2 {print length($0)}' "$FASTQ")
MIN_LEN=$(echo "$READ_LENGTHS" | sort -n | head -1)
MAX_LEN=$(echo "$READ_LENGTHS" | sort -n | tail -1)

# Simpan hasil QC ke report file (sudah disediakan)
{
    echo "=== FASTQ QC REPORT ==="
    echo "Generated : $(date)"
    echo "File      : $FASTQ"
    echo "File size : $FILE_SIZE"
    echo "Total reads: $TOTAL_READS"
    echo "Read range: ${MIN_LEN}-${MAX_LEN} bp"
} > "$FASTQ_REPORT"

log "✅ FASTQ QC report tersimpan di $FASTQ_REPORT"

# ============================================================
# TASK 3: BED FILE ANALYSIS
# ============================================================
log "Step 3: Menganalisis file BED..."
BED_REPORT="${PROJECT_DIR}/results/stats/bed_analysis_report.txt"

# TODO 5: Hitung total genomic region di file BED (gunakan wc -l)
# UBAH baris di bawah ini:
TOTAL_REGIONS=0

# TODO 6: Hitung ada berapa kromosom unik di file BED (kolom ke-1, gunakan cut, sort, uniq, wc)
# UBAH baris di bawah ini:
TOTAL_CHROMS=0

log "  Total regions     : $TOTAL_REGIONS"
log "  Total chromosomes : $TOTAL_CHROMS"

# Simpan hasil BED analisis ke report file (sudah disediakan)
{
    echo "=== BED ANALYSIS REPORT ==="
    echo "Generated : $(date)"
    echo "File      : $BED"
    echo "Total regions: $TOTAL_REGIONS"
    echo "Total chroms : $TOTAL_CHROMS"
} > "$BED_REPORT"

log "✅ BED analysis report tersimpan di $BED_REPORT"

# ============================================================
# TASK 4: SUMMARY REPORT
# ============================================================
log "Step 4: Membuat laporan ringkasan (Summary)..."
SUMMARY="${PROJECT_DIR}/results/pipeline_summary.txt"

# TODO 7: Buat ringkasan sederhana dan simpan ke file $SUMMARY menggunakan redirection >
# Isi laporan minimal memuat:
# - Tanggal analisis
# - Nama file input FASTQ dan BED
# - Total reads dan Total regions
# TULIS perintah Anda di bawah ini untuk membuat file $SUMMARY:


log "✅ Summary report tersimpan di $SUMMARY"
log "🎉 Pipeline Selesai! Semua output tersimpan di folder results/"
