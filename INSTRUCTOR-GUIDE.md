# 🎤 Panduan Instruktur

> Dokumen internal untuk presenter. **Tidak perlu dibagikan ke peserta.**
> Berisi playbook fasilitasi, perkiraan timing, titik macet peserta, dan naskah pembuka/penutup.

---

## 🎯 Tujuan Pembelajaran (Learning Outcomes)

Di akhir workshop, peserta diharapkan mampu:

1. Menjelaskan apa itu terminal, shell, dan bash, serta kenapa relevan untuk biologi
2. Menavigasi sistem file Linux dengan percaya diri (`cd`, `ls`, `mkdir`, dll.)
3. Memproses data teks dengan `grep`, `cut`, `sort`, `uniq`, `awk`, `sed`
4. Mengenali dan memanipulasi format FASTA, FASTQ, dan BED dari command line
5. Menulis bash script sederhana untuk mengotomasi analisis berulang

> 💡 Ulangi outcome ini di pembukaan — peserta belajar lebih baik kalau tahu tujuannya.

---

## ⏱️ Rundown & Timing Detail

| Waktu | Durasi | Sesi | Catatan Fasilitasi |
|-------|--------|------|--------------------|
| 09:50–10:00 | 10' | Open Room | Sapa peserta, minta rename Zoom (Nama_Instansi), pastikan audio jelas |
| 10:00–10:10 | 10' | Pembukaan | Perkenalan, ice-breaker, jelaskan outcome & aturan main |
| 10:10–10:30 | 20' | Modul 1: Terminal Basics | Banyak peserta baru pertama kali buka terminal — pelan-pelan |
| 10:30–10:55 | 25' | Modul 2: Navigasi File | **Titik macet utama** (lihat di bawah) |
| 10:55–11:20 | 25' | Modul 3: Text Processing | Inti workshop — beri waktu lebih |
| 11:20–11:30 | 10' | Modul 4: Format Biologi (intro) | Sambungkan teori ke data nyata |
| 11:30–12:30 | 60' | **ISTIRAHAT** | Ingatkan peserta kembali tepat waktu |
| 12:30–12:35 | 5' | Re-warm up | Recap singkat, cek semua sudah siap |
| 12:35–13:35 | 60' | Hands-on Case 1: FASTA | Breakout room jika peserta banyak |
| 13:35–14:15 | 40' | Hands-on Case 2: Mini Pipeline | Modul 5 (scripting) terintegrasi di sini |
| 14:15–14:30 | 15' | Wrap-up hands-on | Bahas solusi, tunjukkan output yang benar |
| 14:30–14:50 | 20' | Diskusi & Q&A | Siapkan pertanyaan pancingan jika sepi |
| 14:50–15:00 | 10' | Penutup | Resources, sertifikat, feedback form |

> ⚠️ **Realita timing**: Sesi teori hampir selalu molor karena peserta tertinggal saat mengetik. Punya "buffer" mental — lebih baik potong 1 contoh daripada terburu-buru di konsep inti.

---

## 🚧 Titik Macet Peserta (Common Sticking Points)

Berdasarkan pengalaman umum mengajar bash ke pemula biologi:

### 1. Path absolut vs relatif (Modul 2) — **PALING SERING**
Peserta bingung kenapa `cd data` gagal padahal folder `data` "ada".
- **Penyebab**: mereka tidak di direktori parent yang benar.
- **Solusi cepat**: ajarkan refleks `pwd` setiap kali tersesat. "Kalau bingung, `pwd` dulu."

### 2. "command not found"
- Biasanya typo, atau tool belum terinstall.
- Tunjukkan: bash sensitif huruf besar/kecil. `Ls` ≠ `ls`.

### 3. "Permission denied" saat menjalankan script
- Lupa `chmod +x script.sh`.
- Jelaskan konsep executable bit sekali, lalu jadikan kebiasaan.

### 4. Quote tunggal vs ganda di `awk`/`sed`
- Pemula sering tertukar. Untuk workshop ini cukup: "pakai single quote `'...'` untuk awk."

### 5. Windows line endings (peserta WSL)
- File yang dibuat di Notepad Windows punya `\r`. Bisa bikin script error misterius.
- Solusi: `sed -i 's/\r$//' file.sh` — sebutkan jika ada yang errornya aneh.

### 6. Terminal "hang" karena masuk mode interaktif
- Peserta tidak sengaja masuk `less`, `nano`, atau `cat` tanpa argumen.
- Ajarkan jalan keluar: `q` (less), `Ctrl+X` (nano), `Ctrl+C` / `Ctrl+D`.

> 📌 Lihat `TROUBLESHOOTING.md` untuk daftar lengkap — bagikan link itu ke peserta.

---

## 🗣️ Naskah Pembuka (Saran)

> "Selamat datang di workshop *Bash for Biological Data Analysis*! Sebelum mulai — siapa di sini yang hari ini **pertama kali** buka terminal? ... Tidak apa-apa, justru itu tujuan kita. Di akhir hari ini, terminal yang tadinya menakutkan akan jadi alat paling powerful di laptop kalian. Satu aturan main: **jangan takut salah**. Error itu normal, bahkan bioinformatician profesional kena error puluhan kali sehari. Yuk mulai!"

## 🗣️ Naskah Penutup (Saran)

> "Hari ini kalian sudah dari nol sampai bisa menulis pipeline analisis sederhana — itu pencapaian besar! Bash ini fondasi; langkah berikutnya bisa Python, R, atau workflow manager seperti Nextflow. Semua link ada di folder `resources/`. Jangan lupa isi feedback form ya, dan sampai jumpa di komunitas OmicsLite!"

---

## 🧰 Persiapan Teknis Instruktur

**Sehari sebelum workshop:**
- [ ] Tes share screen Zoom + ukuran font terminal **minimal 16pt** (peserta nonton di HP juga!)
- [ ] Siapkan terminal dengan tema kontras tinggi (teks besar, background gelap/terang konsisten)
- [ ] Clone repo bersih di folder demo, jalankan semua script sekali untuk memastikan tidak ada error
- [ ] Siapkan tab browser: repo GitHub, slide, feedback form, daftar hadir
- [ ] Matikan notifikasi & bersihkan desktop (privasi)
- [ ] Siapkan "reset script" untuk mengembalikan folder demo ke kondisi awal antar sesi

**Saat live:**
- [ ] Ketik **pelan** dan baca keras setiap perintah sebelum Enter
- [ ] Sesekali sengaja buat typo lalu perbaiki — tunjukkan error itu wajar
- [ ] Pakai `clear` rutin agar layar tidak penuh
- [ ] Cek chat tiap 5–10 menit; tunjuk co-host untuk memantau kalau ada

---

## 🎮 Strategi Hands-on

- **Bagikan solusi belakangan**: peserta cenderung langsung lihat solusi. Sembunyikan dulu, dorong mencoba 5–10 menit.
- **Breakout room** (jika >15 peserta): kelompok 3–4 orang, satu "screen-sharer" per kelompok.
- **Pacing check**: tanya "✅ kalau sudah, ❓ kalau masih nyangkut" di chat tiap selesai task.
- **Jangan tinggalkan yang tertinggal**: lebih baik selesaikan Case 1 dengan tuntas daripada buru-buru ke Case 2.

---

## 📊 Indikator Keberhasilan Sesi

Workshop dianggap berhasil jika mayoritas peserta bisa:
- ✅ Menjawab kuis pasca-workshop (lihat `assessment/`) dengan skor ≥ 70%
- ✅ Menyelesaikan minimal Case Study 1 secara mandiri
- ✅ Menjalankan satu bash script buatan sendiri tanpa error

---

*Panduan Instruktur · Workshop "Bash for Biological Data Analysis" · OmicsLite · 18 Juli 2026*
