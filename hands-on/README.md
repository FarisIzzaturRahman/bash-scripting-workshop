# 🔬 Hands-on Session — Sesi Praktek

> *"Belajar bioinformatika hanya efektif dengan praktek langsung!"*

---

## 🗺️ Gambaran Sesi Hands-on

```
   ┌──────────────────────────────────────┐
   │  PERSIAPAN                           │
   │  • Pastikan terminal terbuka         │
   │  • Clone/download repo ini           │
   │  • Cek semua file tersedia           │
   └──────────────────────────────────────┘
                      ↓
   ┌──────────────────────────────────────┐
   │  CASE STUDY 1                        │
   │  🧬 Analisis File FASTA              │
   │  • Eksplorasi multi-sequence FASTA   │
   │  • Hitung statistik sequence         │
   │  • Filter & ekstrak sequence         │
   │  • Hitung GC content                 │
   └──────────────────────────────────────┘
                      ↓
   ┌──────────────────────────────────────┐
   │  CASE STUDY 2                        │
   │  🔬 Mini Bioinformatics Pipeline     │
   │  • Setup project structure           │
   │  • Proses file FASTQ                 │
   │  • Otomasi dengan bash script        │
   │  • Generate laporan                  │
   └──────────────────────────────────────┘
                      ↓
   ┌──────────────────────────────────────┐
   │  CASE STUDY 3 (BONUS CHALLENGE)      │
   │  🧬 DNA Motif / Restriction Scanner  │
   │  • Cari situs pemotongan EcoRI       │
   │  • Otomasi pencarian dengan argumen  │
   │  • Konversi indeks koordinat basa    │
   └──────────────────────────────────────┘
                      ↓
   ┌──────────────────────────────────────┐
   │  REVIEW                              │
   │  • Bahas solusi bersama              │
   └──────────────────────────────────────┘
```

---

## 📁 Struktur Data Hands-on

```
hands-on/
├── case01-fasta-analysis/
│   ├── README.md           ← Instruksi lengkap Case Study 1
│   ├── data/
│   │   └── sequences.fasta ← Data untuk dikerjakan
│   └── solutions/
│       └── solution.sh     ← Solusi (JANGAN DILIHAT DULU! 😄)
│
├── case02-mini-pipeline/
│   ├── README.md           ← Instruksi lengkap Case Study 2
│   ├── data/
│   │   ├── reads.fastq     ← Data reads untuk diproses
│   │   └── gene_regions.bed
│   └── solutions/
│       └── solution.sh     ← Solusi (JANGAN DILIHAT DULU! 😄)
│
└── case03-motif-scanner/
    ├── README.md           ← Instruksi lengkap Case Study 3 (Bonus)
    ├── data/
    │   └── lambda_virus.fasta
    └── solutions/
        └── solution.sh     ← Solusi (JANGAN DILIHAT DULU! 😄)
```

---

## 🚀 Cara Memulai

### Langkah 1: Setup
```bash
# Masuk ke direktori hands-on
cd hands-on/

# Buat direktori kerja kamu sendiri
mkdir -p my_work/case01 my_work/case02 my_work/case03

# Lihat semua file yang tersedia
ls -R
```

### Langkah 2: Mulai Case Study 1
```bash
cd case01-fasta-analysis/
cat README.md   # Baca instruksi!
```

### Langkah 3: Mulai Case Study 2
```bash
cd ../case02-mini-pipeline/
cat README.md   # Baca instruksi!
```

### Langkah 4: Mulai Case Study 3 (Bonus Challenge)
```bash
cd ../case03-motif-scanner/
cat README.md   # Baca instruksi!
```
---

## 📝 Tips Sesi Hands-on

> 🔑 **Kunci sukses:**
> 1. **Baca instruksi dengan teliti** sebelum mulai coding
> 2. **Gunakan `man` atau `--help`** jika lupa sintaks perintah
> 3. **Cek output setiap langkah** sebelum lanjut ke langkah berikutnya
> 4. **Jangan langsung lihat solusi** — coba dulu minimal 5 menit!
> 5. **Tanyakan kalau bingung!** Tidak ada pertanyaan yang bodoh

> 💡 **Cheatsheet tersedia di:** `../../cheatsheet/bash-bio-cheatsheet.md`

---

## 🆘 Jika Stuck...

1. Gunakan cheatsheet di folder `cheatsheet/`
2. Lihat modul yang relevan di folder `modules/`
3. Tanyakan ke pemateri atau peserta lain
4. **Sebagai last resort:** lihat solution.sh (tapi pahami, jangan sekedar copy!)

---

*Workshop Bash for Biological Data Analysis — OmicsLite 2026*
