# 🧬 Case Study 3 (BONUS) — DNA Motif / Restriction Enzyme Scanner

> **Level:** Advanced (Bonus Challenge)
> **Data:** `data/lambda_virus.fasta`

---

## 🕵️‍♂️ Latar Belakang: Simulasi Pemotongan Enzim Restriksi
Enzim Restriksi (*Restriction Endonucleases*) adalah protein yang memotong DNA pada urutan basa spesifik yang disebut **situs pengenalan (recognition site / motif)**. Di laboratorium, pencarian lokasi situs pemotongan ini sangat penting untuk kloning gen dan pemetaan DNA.

Di tantangan bonus ini, Anda bertugas membuat alat pencari situs enzim restriksi otomatis yang dapat mencari motif DNA apa pun dan memetakan koordinat basanya secara akurat menggunakan Bash!

---

## 📂 Data Input
File `data/lambda_virus.fasta` berisi potongan sekuens DNA dari virus Bakteriofag Lambda. Beberapa enzim restriksi populer yang akan kita cari adalah:
- **EcoRI**: `GAATTC`
- **HindIII**: `AAGCTT`

---

## 📝 Task 1: Pencarian Cepat di Terminal

Sebelum membuat script otomatis, mari kita coba lakukan pencarian situs pemotongan secara manual satu per satu di terminal.

### 1.1 Hitung Jumlah Situs Pemotongan
Dapatkan sekuens bersih (tanpa header, spasi, atau baris baru), lalu hitung seberapa sering motif EcoRI (`GAATTC`) muncul.

```bash
# Bersihkan sekuens dan cari jumlah motif EcoRI secara case-insensitive
grep -v "^>" data/lambda_virus.fasta | tr -d '\n\r ' | grep -o -i "GAATTC" | wc -l
```

### 1.2 Cari Koordinat Pemotongan (Byte Offset)
Gunakan flag `-b` (*byte-offset*) pada `grep` untuk menampilkan koordinat awal dari setiap kecocokan motif sekuens yang dicari:

```bash
# Menampilkan indeks 0-based dan motif yang cocok
grep -v "^>" data/lambda_virus.fasta | tr -d '\n\r ' | grep -o -b -i "GAATTC"
```

*Catatan: Flag `-b` menunjukkan indeks koordinat dimulai dari 0 (0-based index).*

---

## 📝 Task 2: Lengkapi Script Pemindai Otomatis

Gunakan berkas template `scan_motif_template.sh` yang telah disediakan. Lengkapi bagian `# TODO 1` s.d. `# TODO 4` agar script tersebut dapat menerima parameter file input dan motif secara fleksibel.

1. Buka berkas `scan_motif_template.sh` di editor.
2. Lengkapi TODO sesuai instruksi komentar di dalamnya.
3. Jalankan dan uji script Anda dengan perintah berikut:

```bash
# 1. Cari situs pemotongan EcoRI (GAATTC)
bash scan_motif_template.sh data/lambda_virus.fasta GAATTC

# 2. Cari situs pemotongan HindIII (AAGCTT)
bash scan_motif_template.sh data/lambda_virus.fasta AAGCTT
```

---

## ✅ Checklist Penyelesaian

- [ ] Task 1: Bisa mencari koordinat pemotongan EcoRI menggunakan CLI one-liner
- [ ] Task 2: Melengkapi TODO 1 (Pembersihan sekuens)
- [ ] Task 2: Melengkapi TODO 2 (Pencarian koordinat byte-offset)
- [ ] Task 2: Melengkapi TODO 3 (Perhitungan total jumlah pemotongan)
- [ ] Task 2: Melengkapi TODO 4 (Penerjemahan koordinat menjadi 1-based index)
- [ ] Uji coba: Script berhasil dijalankan tanpa error dan menampilkan hasil yang akurat

---

## 📊 Expected Output

Jika script Anda berjalan dengan benar untuk enzim **EcoRI** (`GAATTC`), keluaran di terminal akan terlihat seperti berikut:

```text
========================================
      RESTRICTION ENZYME SCANNER        
========================================
File FASTA  : data/lambda_virus.fasta
Target Motif: GAATTC
----------------------------------------
Total situs pemotongan: 2

Lokasi pemotongan (Posisi Basa):
----------------------------------------
-> Terdeteksi pada basa ke-185
-> Terdeteksi pada basa ke-447
========================================
```

---

**🔍 Solusi lengkap:** [`solutions/solution.sh`](solutions/solution.sh) *(lihat setelah mencoba!)*

---

*Case Study 3 (Bonus) | Workshop Bash for Biological Data Analysis — OmicsLite 2026*
