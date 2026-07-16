# 🧬 Bash for Biological Data Analysis
### Workshop OmicsLite — Sabtu, 18 Juli 2026

<div align="center">

![Bash](https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white)
![Bioinformatics](https://img.shields.io/badge/Bioinformatics-Beginner-blue?style=for-the-badge)
![OmicsLite](https://img.shields.io/badge/OmicsLite-Workshop-purple?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/FarisIzzaturRahman/bash-scripting-workshop)
*(Klik tombol di atas untuk membuka materi langsung di browser via GitHub Codespaces)*

**"Bioinformatika dimulai dari satu baris command."**

</div>

---

## 📋 Tentang Workshop

Repositori ini adalah **modul resmi hands-on** untuk workshop **Bash for Biological Data Analysis** yang diselenggarakan oleh **OmicsLite**. Workshop ini dirancang untuk pemula — tidak perlu pengalaman programming sebelumnya!

| Detail | Info |
|--------|------|
| 📅 Tanggal | Sabtu, 18 Juli 2026 |
| ⏰ Waktu | 10.00 – 15.00 WIB |
| 🖥️ Platform | Zoom Meeting (Online) |
| 🎯 Level | Beginner / Pemula |
| 🗣️ Bahasa | Bahasa Indonesia + English Technical Terms |

---

## 🗺️ Navigasi Modul

```
bash-bioinformatics-workshop/
│
├── 📦 modules/              # Materi teori (ikuti urutan!)
│   ├── 01-terminal-basics/  # Apa itu terminal & bash?
│   ├── 02-navigasi-file/    # Navigasi file & direktori
│   ├── 03-text-processing/  # Perintah pengolahan teks
│   ├── 04-biological-formats/  # Format file bioinformatika
│   └── 05-bash-scripting/   # Menulis bash script
│
├── 🔬 hands-on/             # Sesi praktek (120 menit)
│   ├── case01-fasta-analysis/   # Analisis file FASTA
│   └── case02-mini-pipeline/    # Mini pipeline bioinformatika
│
├── 📄 cheatsheet/           # Referensi cepat perintah bash
├── 🎬 slides/               # PPT presentasi + modul DOCX (siap live!)
├── 📝 assessment/           # Kuis pasca-workshop + kunci jawaban
├── 📚 resources/            # Referensi & bacaan lanjutan
├── 🖼️ assets/               # Diagram & ilustrasi
├── SETUP.md                 # ⚡ Mulai di sini! Instalasi & setup
├── AGENDA.md                # Rundown workshop
├── FAQ.md                   # ❓ Pertanyaan umum + checklist pra-workshop
├── GLOSSARY.md              # 📖 Kamus istilah teknis
├── TROUBLESHOOTING.md       # 🔧 Solusi error yang sering muncul
└── INSTRUCTOR-GUIDE.md      # 🎤 Panduan untuk pemateri
```

---

## ⚡ Quick Start (Mulai di Sini!)

### Langkah 1: Setup environment
```bash
# Baca panduan setup lengkap di:
cat SETUP.md
```

### Langkah 2: Clone repositori ini
```bash
git clone https://github.com/FarisIzzaturRahman/bash-scripting-workshop.git
cd bash-scripting-workshop
```

### Langkah 3: Verifikasi bash tersedia
```bash
bash --version
echo "Siap belajar bioinformatika! 🧬"
```

---

## 🎯 Tujuan Pembelajaran

Setelah mengikuti workshop ini, peserta mampu:

- ✅ Menggunakan terminal dan command line interface dengan percaya diri
- ✅ Melakukan navigasi dan manajemen file di Linux/macOS
- ✅ Memproses file teks biologis menggunakan perintah bash
- ✅ Memahami format file bioinformatika (FASTA, FASTQ, BED, GFF)
- ✅ Menulis bash script sederhana untuk otomasi analisis
- ✅ Menjalankan mini pipeline analisis data biologis

---

## 📚 Prasyarat

| Yang Perlu | Yang Tidak Perlu |
|-----------|-----------------|
| ✅ Laptop/PC dengan terminal | ❌ Pengalaman programming |
| ✅ Koneksi internet | ❌ Background informatika |
| ✅ Semangat belajar! | ❌ Instalasi software khusus |

> 💡 **Windows user?** Tenang! Panduan instalasi WSL (Windows Subsystem for Linux) tersedia di `SETUP.md`

---

## 📅 Rundown Workshop

| Waktu | Sesi | Modul |
|-------|------|-------|
| 09.50 – 10.00 | Open Room & Persiapan | Setup environment |
| 10.00 – 10.10 | Pembukaan | Intro bioinformatika |
| 10.10 – 11.30 | **Penyampaian Materi** | Modul 1–4 |
| 11.30 – 12.30 | ☕ Istirahat | — |
| 12.30 – 14.30 | **Hands-on Session** | Case Study 1 & 2 |
| 14.30 – 14.50 | Diskusi & Tanya Jawab | — |
| 14.50 – 15.00 | Dokumentasi & Penutup | — |

---

## 🧭 Urutan Belajar yang Disarankan

```
SETUP.md
    ↓
modules/01-terminal-basics/
    ↓
modules/02-navigasi-file/
    ↓
modules/03-text-processing/
    ↓
modules/04-biological-formats/
    ↓
modules/05-bash-scripting/
    ↓
hands-on/case01-fasta-analysis/
    ↓
hands-on/case02-mini-pipeline/
    ↓
cheatsheet/  ← bookmark ini!
```

---

## 🆘 Butuh Bantuan Cepat?

| Kalau kamu... | Buka ini |
|---------------|----------|
| Baru pertama kali & ingin persiapan | [FAQ.md](FAQ.md) — checklist pra-workshop |
| Bingung dengan istilah teknis | [GLOSSARY.md](GLOSSARY.md) — kamus istilah |
| Kena error & panik | [TROUBLESHOOTING.md](TROUBLESHOOTING.md) — solusi error umum |
| Butuh referensi perintah cepat | [cheatsheet/](cheatsheet/bash-bio-cheatsheet.md) |
| Ingin menguji pemahaman | [assessment/](assessment/quiz.md) — kuis + kunci jawaban |
| Mau belajar lebih lanjut | [resources/](resources/README.md) — buku, tools, komunitas |
| Seorang pemateri/instruktur | [INSTRUCTOR-GUIDE.md](INSTRUCTOR-GUIDE.md) |
| Butuh slide presentasi / modul cetak | [slides/](slides/) — PPTX & DOCX siap pakai |

---

## 👨‍🏫 Pemateri

Disampaikan oleh praktisi bioinformatika aktif dengan pengalaman dalam analisis data genomik, transcriptomik, dan workflow bioinformatika berbasis Linux.

---

## 🤝 Penyelenggara

**OmicsLite** — Komunitas belajar omics & bioinformatika yang terbuka dan aplikatif untuk semua kalangan di Indonesia.

---

## 📜 Lisensi

Materi ini merupakan hak penggunaan **OmicsLite**. Pemateri tetap dapat mencantumkan kegiatan ini sebagai bagian dari portofolio profesional. Lihat [LICENSE](LICENSE) untuk detail.

---

<div align="center">

*Selamat belajar! Setiap bioinformatician hebat dimulai dari `echo "Hello, World!"` 🧬*

**OmicsLite × Workshop Bash for Biological Data Analysis 2026**

</div>
