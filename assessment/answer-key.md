# ✅ Kunci Jawaban Kuis

> Jangan mengintip sebelum mengerjakan [`quiz.md`](quiz.md)! 😉
> Setiap jawaban disertai penjelasan singkat agar kamu paham *kenapa*, bukan sekadar tahu jawabannya.

---

## Bagian A — Konsep Dasar

**1. b)** Program yang menerjemahkan perintah teks ke sistem operasi.
> Shell adalah perantara antara kamu dan kernel. Terminal (a) hanya jendelanya; kernel (c) adalah inti OS.

**2. c)** `pwd` (*print working directory*).
> Jurus orientasi nomor satu saat tersesat.

**3. c)** Home directory.
> `~` adalah singkatan dari `/home/namamu`. Root sistem adalah `/`.

**4. c)** `/home/user/data/seq.fasta`.
> Absolute path selalu dimulai dengan `/`. Pilihan lain adalah path relatif.

**5. b)** Tekan `q`.
> `q` untuk quit dari `less`/`man`. `Ctrl+C` untuk membatalkan proses berjalan.

---

## Bagian B — Pemrosesan Teks

**6. b)** `grep -c "^>" file.fasta`.
> `^>` mencari baris yang **dimulai** dengan `>` (header FASTA), `-c` menghitungnya. Jawaban (a) salah karena menghitung semua baris termasuk sekuens.

**7. c)** Menyalurkan output satu perintah jadi input perintah berikutnya.
> Inti kekuatan bash. Menyimpan ke file (a) adalah tugas `>`.

**8. b)** `>` menimpa file, `>>` menambah ke akhir file.
> Hati-hati dengan `>` — bisa menghapus isi file lama tanpa peringatan!

**9. b)** Mencari "homo" mengabaikan besar/kecil huruf.
> `-i` = *case-insensitive*. Membalik hasil (d) adalah tugas `-v`.

**10. b)** `cut -d '|' -f 3 file.txt`.
> `-d '|'` mengatur delimiter jadi `|`, `-f 3` mengambil kolom ketiga. Tanpa `-d`, `cut` mengira pemisahnya TAB.

**11. b)** Mengurutkan sebagai angka (numerik).
> Tanpa `-n`, `sort` memperlakukan angka sebagai teks (10 muncul sebelum 2).

**12. a)** `cut -f 1 file.bed | sort | uniq -c`.
> Pola klasik: ambil kolom → urutkan → hitung unik. `uniq` butuh input terurut, makanya `sort` dulu.

---

## Bagian C — Format Biologi

**13. b)** `>`.
> Header FASTA diawali `>`. FASTQ menggunakan `@` (a).

**14. d)** 4 baris.
> Header (`@`), sekuens, pemisah (`+`), string kualitas.

**15. b)** 0-based.
> BED menghitung posisi mulai dari 0. (Bandingkan: GFF/GTF menggunakan 1-based.)

**16. c)** 99.9%.
> Phred 30 → 1 error per 1000 basa. Phred 20 = 99%, Phred 40 = 99.99%.

**17. b)** Persentase basa G dan C dalam sekuens.
> Indikator biologis penting, misalnya untuk stabilitas DNA dan desain primer.

---

## Bagian D — Scripting

**18. b)** `#!/usr/bin/env bash`.
> Shebang memberi tahu sistem program apa yang menjalankan script.

**19. b)** `NAMA="workshop"`.
> TANPA spasi di sekitar `=`. Spasi (a) akan menyebabkan error.

**20. a)** `chmod +x script.sh`.
> Memberi izin executable. Alternatif: jalankan dengan `bash script.sh` tanpa perlu chmod.

---

## Bagian E — Esai (Contoh Jawaban)

**B1.** Menghitung jumlah read:
```bash
echo $(($(wc -l < reads.fastq) / 4))
```
> Total baris dibagi 4 (karena tiap read = 4 baris). Jawaban lain yang valid: `awk 'END{print NR/4}' reads.fastq`.

**B2.** Kenapa raw data tidak boleh diubah:
> Data mentah adalah sumber kebenaran tunggal. Jika diubah/rusak, hasil analisis tidak bisa direproduksi dan tidak bisa dikembalikan. Semua analisis sebaiknya dilakukan pada **salinan**, sehingga kalau ada kesalahan, kita selalu bisa mulai lagi dari data asli. Ini prinsip **reprodusibilitas** dalam sains.

**B3.** Ekstrak header ke file:
```bash
grep "^>" sequences.fasta > headers.txt
```
> `^>` mencari baris header, `>` menyimpannya ke file baru. (Catatan: jangan tulis ke file yang sedang dibaca!)

---

## 📊 Hitung Skormu

| Benar | Penilaian |
|-------|-----------|
| 18–20 | 🏆 Luar biasa! Kamu siap lanjut ke Python/R |
| 14–17 | ✅ Lulus! Pemahaman solid |
| 10–13 | 📚 Cukup baik — review modul yang masih lemah |
| < 10 | 💪 Tidak apa-apa! Ulangi materi & latihan hands-on lagi |

> Soal esai (B1–B3) adalah bonus — bagus untuk memperdalam, tidak dihitung dalam 20 soal utama.

**Mau memperdalam?** Cek [`resources/README.md`](../resources/README.md) untuk jalur belajar lanjutan.

---

*Kunci Jawaban · "Bash for Biological Data Analysis" · OmicsLite · 18 Juli 2026*
