# ⚡ SETUP — Persiapan Environment

> **Selesaikan setup ini SEBELUM workshop dimulai!**
> Estimasi waktu: 10–20 menit

---

## 🚀 Cara Paling Praktis: GitHub Codespaces (Sangat Direkomendasikan)

Kamu tidak perlu menginstal apa pun di laptopmu! Semua alat pendukung (`bash`, `grep`, `awk`, `sed`, `bc`, `tree`) serta ekstensi editor khusus bioinformatika sudah terkonfigurasi otomatis di cloud.

1. Buka halaman utama repositori GitHub ini.
2. Klik tombol **Open in GitHub Codespaces** (warna hijau) yang ada di bagian atas `README.md`.
3. Masuk dengan akun GitHub kamu (atau buat baru jika belum punya).
4. Tunggu 1–2 menit hingga lingkungan terminal virtual siap digunakan langsung di browser.
5. Kamu sudah siap belajar!

---

## 🖥️ Atau Setup Secara Lokal (Alternatif):
Jika kamu ingin menjalankan semuanya langsung di komputer sendiri:

- [Linux (Ubuntu/Debian)](#-linux-ubuntudebian)
- [macOS](#-macos)
- [Windows (via WSL)](#-windows-via-wsl)

---

## 🐧 Linux (Ubuntu/Debian)

Bash sudah tersedia secara default! Tinggal verifikasi:

```bash
# Buka terminal (Ctrl+Alt+T atau cari "Terminal" di aplikasi)

# Cek versi bash
bash --version
# Output: GNU bash, version 5.x.x ...

# Cek tools dasar
echo "Bash: $(bash --version | head -1)"
echo "grep: $(grep --version | head -1)"
echo "awk:  $(awk --version | head -1)"
echo "sed:  $(sed --version | head -1)"
```

✅ Jika semua muncul, kamu siap!

---

## 🍎 macOS

macOS menggunakan `zsh` sebagai default, tapi `bash` juga tersedia.

### Option A: Gunakan Terminal bawaan (Recommended untuk workshop)
```bash
# Buka Terminal (Cmd+Space → ketik "Terminal")

# Cek bash
bash --version
# Output mungkin: GNU bash, version 3.x (macOS lama) atau 5.x (macOS baru)
```

### Option B: Install bash terbaru via Homebrew (opsional)
```bash
# Install Homebrew jika belum ada
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install bash terbaru
brew install bash

# Verifikasi
bash --version
```

### Verifikasi tools
```bash
# Di macOS, beberapa tools punya versi berbeda tapi fungsi sama
which bash grep awk sed
echo "Semua tools tersedia ✅"
```

---

## 🪟 Windows (via WSL)

Windows tidak memiliki bash native, tapi kita bisa menggunakan **WSL (Windows Subsystem for Linux)** — ini adalah cara terbaik untuk belajar bioinformatika di Windows!

### Langkah 1: Enable WSL
Buka **PowerShell sebagai Administrator** dan jalankan:
```powershell
wsl --install
```
Restart komputer setelah selesai.

### Langkah 2: Install Ubuntu dari Microsoft Store
1. Buka **Microsoft Store**
2. Cari **"Ubuntu 22.04 LTS"**
3. Klik **Install**
4. Setelah selesai, buka Ubuntu dari Start Menu
5. Buat username dan password Linux kamu

### Langkah 3: Update Ubuntu
```bash
# Di terminal Ubuntu (WSL)
sudo apt update && sudo apt upgrade -y
```

### Langkah 4: Verifikasi
```bash
bash --version
echo "WSL + Bash siap digunakan! ✅"
```

> 💡 **Tips WSL:** Kamu bisa akses file Windows di `/mnt/c/Users/NamaKamu/`

---

## 🔧 Install Tools Tambahan (Opsional)

Untuk workshop ini, hanya bash dasar yang diperlukan. Tapi jika ingin eksplorasi lebih lanjut:

```bash
# Ubuntu/WSL
sudo apt update
sudo apt install -y tree curl wget

# macOS (dengan Homebrew)
brew install tree curl wget

# Verifikasi
tree --version
curl --version | head -1
```

---

## 📁 Clone Repository Workshop

```bash
# Pastikan git tersedia
git --version

# Clone repo
git clone https://github.com/FarisIzzaturRahman/bash-scripting-workshop.git

# Masuk ke direktori
cd bash-scripting-workshop

# Lihat isi repo
ls -la
```

### Jika tidak bisa clone, download manual:
1. Buka URL repo di browser
2. Klik tombol **Code → Download ZIP**
3. Extract ZIP dan buka terminal di folder tersebut

---

## ✅ Checklist Verifikasi Final

Jalankan script berikut untuk memverifikasi semua setup:

```bash
#!/usr/bin/env bash
echo "========================================="
echo "  VERIFIKASI SETUP WORKSHOP OMICSLITE"
echo "========================================="
echo ""

# Check bash
echo -n "✓ Bash:  "
bash --version | head -1

# Check basic tools
for tool in grep awk sed cut sort uniq wc head tail cat; do
    echo -n "✓ $tool: "
    which $tool && echo "OK" || echo "❌ TIDAK DITEMUKAN"
done

echo ""
echo "✅ Setup selesai! Sampai jumpa di workshop!"
echo "========================================="
```

Simpan sebagai `verify_setup.sh` dan jalankan:
```bash
bash verify_setup.sh
```

---

## ❓ Troubleshooting

| Masalah | Solusi |
|---------|--------|
| `bash: command not found` | Install bash via package manager |
| `Permission denied` saat buka terminal | Coba buka sebagai admin |
| WSL install gagal | Pastikan virtualization enabled di BIOS |
| Git clone error | Coba download ZIP manual |

---

## 📞 Bantuan

Jika mengalami masalah setup, hubungi panitia OmicsLite sebelum hari H workshop melalui:
- Media sosial OmicsLite
- Chat grup peserta workshop

---

> ⚠️ **Penting:** Selesaikan setup minimal **1 hari sebelum workshop** agar kita bisa membantu jika ada kendala!
