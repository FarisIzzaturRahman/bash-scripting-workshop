# 🔬 Case Study 2 — Mini Bioinformatics Pipeline

> **Durasi:** 40 menit
> **Level:** Beginner–Intermediate
> **Data:** `data/reads.fastq` dan `data/gene_regions.bed`

---

## 📖 Latar Belakang

Kamu baru mendapatkan data dari **departemen sequencing**:
- File FASTQ berisi hasil NGS reads
- File BED berisi daftar genomic region yang menarik

Tugasmu: **Bangun sebuah pipeline bash yang otomatis** menganalisis kedua file tersebut dan menghasilkan laporan ringkas.

Pipeline yang akan dibangun:

```
[INPUT: reads.fastq + gene_regions.bed]
           ↓
    Step 1: Setup Project Structure
           ↓
    Step 2: QC Report FASTQ
     (jumlah reads, kualitas, dll)
           ↓
    Step 3: Analisis BED File
     (statistik region, distribusi)
           ↓
    Step 4: Generate Summary Report
           ↓
[OUTPUT: laporan lengkap di results/]
```

---

## 🎯 Tujuan

- Membangun project directory structure yang terorganisir
- Menganalisis FASTQ file menggunakan bash murni
- Menganalisis BED file untuk statistik genomik
- Membuat bash script yang modular dan terdokumentasi
- Menghasilkan laporan analisis otomatis

---

## 📋 Persiapan

```bash
# Masuk ke direktori case study 2
cd hands-on/case02-mini-pipeline/

# Lihat data yang tersedia
ls -lh data/

# Preview file
head -8 data/reads.fastq    # 8 baris = 2 reads FASTQ
head -10 data/gene_regions.bed
```

---

## 📝 Task 1: Setup Project Structure (5 menit)

Setiap analisis bioinformatika yang baik dimulai dengan **struktur direktori yang terorganisir**.

**Tugas:** Buat struktur berikut menggunakan satu perintah bash:

```
my_pipeline/
├── data/
│   ├── raw/
│   └── processed/
├── results/
│   ├── qc/
│   └── stats/
├── scripts/
└── logs/
```

```bash
# Buat semua direktori sekaligus
mkdir -p my_pipeline/data/{raw,processed} \
         my_pipeline/results/{qc,stats} \
         my_pipeline/scripts \
         my_pipeline/logs

# Verifikasi
find my_pipeline/ -type d | sort
```

**Salin data ke direktori raw:**
```bash
cp data/reads.fastq my_pipeline/data/raw/
cp data/gene_regions.bed my_pipeline/data/raw/
```

---

## 📝 Task 2: QC Analysis FASTQ (15 menit)

### 2.1 Statistik dasar FASTQ

```bash
# Hitung jumlah reads
# (Ingat: FASTQ = 4 baris per read)
wc -l data/reads.fastq | awk '{print $1/4, "total reads"}'

# Cara alternatif
grep -c "^@SRR" data/reads.fastq
```

### 2.2 Panjang reads

```bash
# Panjang read pertama
head -2 data/reads.fastq | tail -1 | wc -c

# Panjang semua reads (tanpa newline)
awk 'NR%4==2 {print length($0)}' data/reads.fastq

# Min, max, rata-rata panjang reads
awk 'NR%4==2 {len=length($0); sum+=len; n++; 
              if(len>max) max=len; 
              if(n==1||len<min) min=len}
     END {print "Min:", min, "bp"; 
          print "Max:", max, "bp"; 
          print "Avg:", sum/n, "bp"}' data/reads.fastq
```

### 2.3 Analisis kualitas (Phred scores)

```bash
# Tampilkan quality string dari semua reads
awk 'NR%4==0' data/reads.fastq

# Hitung rata-rata quality score per read
# Phred+33: karakter ASCII - 33 = Phred score
awk 'NR%4==0 {
    sum=0; len=length($0);
    for(i=1; i<=len; i++) {
        c = substr($0, i, 1)
        sum += ord(c) - 33
    }
    print NR/4, "avg_quality:", sum/len
}
function ord(c) { return index("!\"#$%&'\''()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~", c) + 32 }' data/reads.fastq
```

> 💡 Cara lebih sederhana: hitung proporsi karakter quality tinggi

```bash
# Hitung reads dengan quality string mengandung banyak I (Q40)
awk 'NR%4==0' data/reads.fastq | grep -c "IIIIIII"

# Cek reads berkualitas rendah (banyak !)
awk 'NR%4==0' data/reads.fastq | grep -c "!!!!!"
```

### 2.4 Tugas — Buat QC report

**Tugas:** Simpan statistik FASTQ ke file hasil:

```bash
# Buat QC report sederhana
{
    echo "===== FASTQ QC REPORT ====="
    echo "File: data/reads.fastq"
    echo "Date: $(date)"
    echo ""
    echo "Total reads: $(grep -c "^@" data/reads.fastq)"
    echo "File size: $(du -sh data/reads.fastq | cut -f1)"
    echo ""
    # Tambahkan statistik lain yang sudah kamu hitung...
} > my_pipeline/results/qc/fastq_qc_report.txt

cat my_pipeline/results/qc/fastq_qc_report.txt
```

---

## 📝 Task 3: Analisis BED File (10 menit)

### 3.1 Statistik dasar BED

```bash
# Berapa total region?
wc -l data/gene_regions.bed

# Berapa kromosom yang ada?
cut -f 1 data/gene_regions.bed | sort -u | wc -l

# Daftar kromosom
cut -f 1 data/gene_regions.bed | sort -u
```

### 3.2 Distribusi per kromosom

**Tugas:** Buat tabel berapa region per kromosom, diurutkan dari terbanyak:

```bash
# Tulis perintahmu di sini:
# ...

# Expected output:
#  10 chr1
#   5 chr2
#   3 chr3
# ... dst
```

### 3.3 Hitung panjang region

```bash
# Panjang setiap region (end - start)
awk '{print $4, $3-$2}' data/gene_regions.bed

# Statistik panjang
awk '{len=$3-$2; sum+=len; n++; 
      if(len>max||n==1) max=len; 
      if(len<min||n==1) min=len} 
     END {print "Total regions:", n; 
          print "Min length:", min, "bp";
          print "Max length:", max, "bp";
          print "Avg length:", int(sum/n), "bp";
          print "Total coverage:", sum, "bp"}' data/gene_regions.bed
```

### 3.4 Filter region

```bash
# Ambil region di chr1 saja
awk '$1 == "chr1"' data/gene_regions.bed

# Ambil region lebih panjang dari 5000 bp
awk '($3 - $2) > 5000' data/gene_regions.bed

# Ambil region di strand positif
awk '$6 == "+"' data/gene_regions.bed

# Hitung jumlah region di setiap strand
awk '{print $6}' data/gene_regions.bed | sort | uniq -c
```

---

## 📝 Task 4: Buat Pipeline Script (10 menit)

Sekarang saatnya menggabungkan semua analisis di atas ke dalam **satu bash script yang bisa dijalankan otomatis**!

**Tugas:** Buat file `my_pipeline/scripts/run_pipeline.sh`

```bash
#!/usr/bin/env bash
# ============================================================
# run_pipeline.sh — Mini Bioinformatics Pipeline
# OmicsLite Workshop 2026
# Penggunaan: bash run_pipeline.sh <fastq_file> <bed_file>
# ============================================================

set -euo pipefail

# ---- Konfigurasi ----
FASTQ="${1:-data/reads.fastq}"
BED="${2:-data/gene_regions.bed}"
RESULTS_DIR="results"
LOG_FILE="logs/pipeline_$(date '+%Y%m%d_%H%M%S').log"

# ---- Setup ----
mkdir -p "$RESULTS_DIR/qc" "$RESULTS_DIR/stats" "logs"

# ---- Fungsi logging ----
log() {
    echo "[$(date '+%H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# ---- Mulai pipeline ----
log "Memulai pipeline analisis..."
log "FASTQ: $FASTQ"
log "BED:   $BED"

# ---- Step 1: Validasi input ----
log "Step 1: Validasi input file..."

# Tambahkan validasi file di sini!
# (Cek apakah file ada dengan [ -f ] )
# ...

log "  ✅ Input file tervalidasi"

# ---- Step 2: FASTQ QC ----
log "Step 2: Analisis FASTQ..."

{
    echo "FASTQ QC Report"
    echo "Generated: $(date)"
    echo "File: $FASTQ"
    echo "---"

    # Hitung reads
    READS=$(grep -c "^@" "$FASTQ")
    echo "Total reads: $READS"

    # Ukuran file
    echo "File size: $(du -sh "$FASTQ" | cut -f1)"

    # Tambahkan statistik lain...
} > "$RESULTS_DIR/qc/fastq_report.txt"

log "  ✅ FASTQ QC selesai → $RESULTS_DIR/qc/fastq_report.txt"

# ---- Step 3: BED Analysis ----
log "Step 3: Analisis BED..."

{
    echo "BED Analysis Report"
    echo "Generated: $(date)"
    echo "File: $BED"
    echo "---"

    echo "Total regions: $(wc -l < "$BED")"
    echo ""
    echo "Distribusi per kromosom:"
    cut -f 1 "$BED" | sort | uniq -c | sort -rn

    echo ""
    echo "Statistik panjang region:"
    awk '{len=$3-$2; sum+=len; n++;
          if(len>max||n==1) max=len;
          if(len<min||n==1) min=len}
         END {print "Min:", min, "bp";
              print "Max:", max, "bp";
              print "Avg:", int(sum/n), "bp";
              print "Total:", sum, "bp"}' "$BED"
} > "$RESULTS_DIR/stats/bed_analysis.txt"

log "  ✅ BED analysis selesai → $RESULTS_DIR/stats/bed_analysis.txt"

# ---- Selesai ----
log "Pipeline selesai! Lihat hasil di: $RESULTS_DIR/"
```

**Jalankan pipeline:**
```bash
chmod +x my_pipeline/scripts/run_pipeline.sh
bash my_pipeline/scripts/run_pipeline.sh

# Lihat hasilnya
cat my_pipeline/results/qc/fastq_report.txt
cat my_pipeline/results/stats/bed_analysis.txt
cat my_pipeline/logs/*.log
```

---

## ✅ Checklist Penyelesaian

- [ ] Task 1: Membuat project directory structure
- [ ] Task 2: Menghitung jumlah reads dan panjang rata-rata
- [ ] Task 2: Membuat QC report FASTQ
- [ ] Task 3: Menghitung distribusi region per kromosom
- [ ] Task 3: Menghitung statistik panjang region
- [ ] Task 4: Membuat script pipeline yang lengkap
- [ ] Task 4: Pipeline berjalan tanpa error dan menghasilkan output

---

**🔍 Solusi lengkap:** [`solutions/solution.sh`](solutions/solution.sh)

---

*Case Study 2 | Workshop Bash for Biological Data Analysis — OmicsLite 2026*
