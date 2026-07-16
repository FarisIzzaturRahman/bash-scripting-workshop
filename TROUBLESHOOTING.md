# 🔧 Troubleshooting — Solusi Error yang Sering Muncul

> Panik karena error? Tenang — **error itu normal**. Halaman ini berisi error paling umum yang ditemui pemula beserta solusinya. Cari pesan error-mu di bawah.

---

## 🔴 `command not found`

```
bash: grpe: command not found
```

**Penyebab & solusi:**
- **Typo** — paling sering! Bash sensitif huruf. Cek ejaan: `grpe` → `grep`, `Ls` → `ls`.
- **Tool belum terinstall** — misal `tree`, `awk` versi tertentu. Install dengan:
  ```bash
  sudo apt install nama-tool      # Linux / WSL
  brew install nama-tool          # macOS
  ```
- **Spasi salah tempat** — `cd..` salah, harus `cd ..` (ada spasi).

---

## 🔴 `No such file or directory`

```
cat: sequences.fasta: No such file or directory
```

**Penyebab & solusi:**
- Kamu **tidak berada di folder yang benar**. Cek posisi:
  ```bash
  pwd          # Di mana saya sekarang?
  ls           # File apa saja yang ada di sini?
  ```
- **Typo nama file** — pakai `Tab` untuk auto-complete agar tidak salah ketik.
- **Path salah** — kalau file ada di subfolder: `cat data/sequences.fasta`.

> 💡 **Jurus sakti**: kalau bingung, selalu mulai dengan `pwd` lalu `ls`.

---

## 🔴 `Permission denied`

### Saat menjalankan script:
```
bash: ./script.sh: Permission denied
```
**Solusi** — beri izin executable:
```bash
chmod +x script.sh
./script.sh
```
Atau jalankan langsung dengan bash (tanpa perlu chmod):
```bash
bash script.sh
```

### Saat mengakses file/folder sistem:
```
mkdir: cannot create directory '/usr/data': Permission denied
```
**Solusi** — jangan bekerja di folder sistem. Pindah ke home directory:
```bash
cd ~
mkdir data    # Sekarang berhasil
```

---

## 🔴 Terminal "Hang" / Tidak Bisa Mengetik

Kamu menekan Enter dan terminal "diam", kursor tidak kembali ke prompt biasa.

| Situasi | Cara keluar |
|---------|-------------|
| Masuk `less` / `more` (baca file) | Tekan `q` |
| Masuk editor `nano` | `Ctrl+X` |
| Masuk editor `vim`/`vi` | Tekan `Esc`, ketik `:q!`, Enter |
| `cat` tanpa argumen (nunggu input) | `Ctrl+C` atau `Ctrl+D` |
| Proses lama berjalan | `Ctrl+C` untuk batalkan |
| Prompt jadi `>` (quote belum ditutup) | Ketik `'` atau `"` lalu Enter, atau `Ctrl+C` |

> Prompt `>` muncul karena kamu lupa menutup tanda kutip. Bash mengira perintahmu belum selesai.

---

## 🔴 Script Error Misterius (Windows / WSL)

```
./script.sh: line 2: $'\r': command not found
```

**Penyebab**: File dibuat/diedit di aplikasi Windows (Notepad) yang menambahkan karakter `\r` (carriage return) tak terlihat di akhir baris.

**Solusi** — bersihkan line endings:
```bash
# Linux / WSL:
sed -i 's/\r$//' script.sh

# macOS:
sed -i '' 's/\r$//' script.sh

# Atau gunakan dos2unix jika tersedia:
dos2unix script.sh
```

> 💡 **Pencegahan**: edit file `.sh` dengan editor yang mendukung LF (VS Code, nano), bukan Notepad bawaan Windows.

---

## 🔴 Error `sed` di macOS (BSD vs GNU)

```
sed: 1: "script.sh": extra characters at the end of l command
# atau
sed: -i may not be used with stdin
```

**Penyebab**: Perintah `sed -i` (in-place edit) di macOS (BSD `sed`) memerlukan argumen tambahan untuk backup ekstensi, berbeda dengan Linux/WSL (GNU `sed`) yang opsional.

**Solusi**:
Tambahkan tanda kutip kosong `''` setelah `-i` untuk memberi tahu `sed` agar tidak membuat file backup:
```bash
sed -i '' 's/old/new/g' file.txt
```

---

## 🔴 `grep`/`awk` Tidak Mengembalikan Apa-apa

Perintah jalan tanpa error, tapi output kosong.

**Cek hal-hal ini:**
- **Case sensitivity** — `grep "homo"` ≠ `grep "Homo"`. Pakai `-i` untuk abaikan kapital:
  ```bash
  grep -i "homo sapiens" sequences.fasta
  ```
- **Pola memang tidak ada** — coba pola lebih sederhana dulu untuk memastikan.
- **Salah delimiter di `cut`** — default `cut` pakai TAB. Kalau filenya pakai `|`:
  ```bash
  cut -d '|' -f 2 file.txt
  ```

---

## 🔴 `>` Menimpa File yang Salah (Data Hilang!)

```bash
grep ">" data.fasta > data.fasta   # ❌ BAHAYA! File jadi kosong
```

**Penyebab**: `>` menimpa file **sebelum** perintah dibaca, jadi input ikut terhapus.

**Pencegahan:**
- Jangan pernah menulis ke file yang sedang dibaca di perintah yang sama.
- Tulis ke file baru: `grep ">" data.fasta > headers.txt`
- Backup data mentah & jadikan read-only:
  ```bash
  chmod 444 data/raw/*.fasta   # Hanya bisa dibaca
  ```

> 🛡️ **Aturan emas bioinformatika**: JANGAN PERNAH mengubah data mentah (raw data). Selalu kerja di salinan.

---

## 🔴 Hasil `sort` Aneh (10 sebelum 2)

```
1
10
2
3
```

**Penyebab**: `sort` default mengurutkan sebagai teks, bukan angka.

**Solusi** — pakai `-n` untuk numerik:
```bash
sort -n angka.txt
```

---

## 🔴 Variabel Bash Kosong / Tidak Terbaca

```bash
NAMA = "workshop"    # ❌ SALAH — ada spasi di sekitar =
NAMA="workshop"      # ✅ BENAR — tanpa spasi
echo $NAMA
```

**Aturan:**
- **Assign**: tanpa spasi → `NAMA="nilai"`
- **Pakai**: pakai `$` → `echo "$NAMA"`
- Selalu bungkus variabel dengan tanda kutip: `"$NAMA"` (aman dari spasi).

---

## 🔴 Zoom/Workshop: Tidak Bisa Lihat Terminal Instruktur

- Pastikan kamu menerima screen share (klik "View Options" → "Fit to Window").
- Kalau teks terlalu kecil, minta instruktur perbesar font, atau zoom layar HP/laptopmu.

---

## 🆘 Masih Stuck?

1. **Baca pesan error pelan-pelan** — biasanya menyebut file/baris yang bermasalah.
2. **Salin pesan error ke Google** — kemungkinan besar orang lain pernah mengalami.
3. **Cek glosarium** (`GLOSSARY.md`) kalau ada istilah yang tidak dimengerti.
4. **Tanya di chat workshop** — tidak ada pertanyaan yang bodoh!
5. `explainshell.com` — tempel perintahmu, dia jelaskan tiap bagiannya.

---

*Troubleshooting · Workshop "Bash for Biological Data Analysis" · OmicsLite · 18 Juli 2026*
