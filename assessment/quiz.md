# 📝 Kuis Pasca-Workshop

> Uji pemahamanmu! Kerjakan sendiri dulu tanpa melihat kunci jawaban. Kunci ada di [`answer-key.md`](answer-key.md).
>
> **20 soal · Target lulus: 70% (14 benar)**

---

## Bagian A — Konsep Dasar (Pilihan Ganda)

**1.** Apa yang dimaksud dengan "shell"?
- a) Aplikasi jendela tempat mengetik
- b) Program yang menerjemahkan perintah teks ke sistem operasi
- c) Inti sistem operasi yang mengatur hardware
- d) Bahasa pemrograman untuk biologi

**2.** Perintah untuk mengetahui di direktori mana kamu sekarang berada:
- a) `ls`
- b) `cd`
- c) `pwd`
- d) `where`

**3.** Simbol `~` (tilde) merujuk pada:
- a) Direktori root sistem
- b) Direktori parent
- c) Home directory
- d) Direktori saat ini

**4.** Manakah yang merupakan **absolute path**?
- a) `data/seq.fasta`
- b) `../results`
- c) `/home/user/data/seq.fasta`
- d) `./script.sh`

**5.** Untuk keluar dari tampilan `man` atau `less`, tekan:
- a) `Ctrl+C`
- b) `q`
- c) `Esc`
- d) `exit`

---

## Bagian B — Pemrosesan Teks

**6.** Perintah menghitung jumlah sekuens dalam file FASTA:
- a) `wc -l file.fasta`
- b) `grep -c "^>" file.fasta`
- c) `cat file.fasta | wc`
- d) `sort file.fasta`

**7.** Apa fungsi simbol pipe `|`?
- a) Menyimpan output ke file
- b) Menjalankan perintah di background
- c) Menyalurkan output satu perintah jadi input perintah berikutnya
- d) Menghapus file

**8.** Perbedaan `>` dan `>>`:
- a) `>` menambah ke file, `>>` menimpa file
- b) `>` menimpa file, `>>` menambah ke akhir file
- c) Keduanya sama
- d) `>` untuk teks, `>>` untuk angka

**9.** Perintah `grep -i "homo"` akan:
- a) Mencari "homo" persis huruf besar/kecilnya
- b) Mencari "homo" mengabaikan besar/kecil huruf
- c) Menghitung kemunculan "homo"
- d) Membalik hasil pencarian

**10.** Untuk mengambil kolom ke-3 dari file yang dipisah karakter `|`:
- a) `cut -f 3 file.txt`
- b) `cut -d '|' -f 3 file.txt`
- c) `grep 3 file.txt`
- d) `awk 3 file.txt`

**11.** Perintah `sort -n` digunakan untuk:
- a) Mengurutkan terbalik
- b) Mengurutkan sebagai angka (numerik)
- c) Menghapus duplikat
- d) Mengurutkan berdasarkan kolom

**12.** Kombinasi yang menghitung jumlah kemunculan tiap kromosom dalam file BED:
- a) `cut -f 1 file.bed | sort | uniq -c`
- b) `grep chr file.bed`
- c) `wc -l file.bed`
- d) `sort file.bed | head`

---

## Bagian C — Format Biologi

**13.** Di file FASTA, baris header diawali dengan karakter:
- a) `@`
- b) `>`
- c) `#`
- d) `+`

**14.** Satu read dalam file FASTQ terdiri dari berapa baris?
- a) 1
- b) 2
- c) 3
- d) 4

**15.** Format BED menggunakan sistem koordinat:
- a) 1-based
- b) 0-based
- c) Tergantung file
- d) Tidak punya koordinat

**16.** Phred score 30 berarti akurasi pembacaan basa sekitar:
- a) 90%
- b) 99%
- c) 99.9%
- d) 99.99%

**17.** "GC content" adalah:
- a) Jumlah total basa dalam sekuens
- b) Persentase basa G dan C dalam sekuens
- c) Skor kualitas sekuens
- d) Panjang sekuens

---

## Bagian D — Scripting

**18.** Baris pertama bash script yang benar (shebang):
- a) `# bash`
- b) `#!/usr/bin/env bash`
- c) `run bash`
- d) `bash start`

**19.** Cara menulis variabel yang BENAR di bash:
- a) `NAMA = "workshop"`
- b) `NAMA="workshop"`
- c) `$NAMA = workshop`
- d) `var NAMA = workshop`

**20.** Sebelum menjalankan script dengan `./script.sh`, kamu mungkin perlu:
- a) `chmod +x script.sh`
- b) `rm script.sh`
- c) `cat script.sh`
- d) `sort script.sh`

---

## ✍️ Bagian E — Esai Singkat (Bonus)

**B1.** Tuliskan satu baris perintah untuk menghitung jumlah read dalam file `reads.fastq`. (Petunjuk: 1 read = 4 baris)

**B2.** Jelaskan dengan kata-katamu sendiri kenapa kita TIDAK BOLEH mengubah file data mentah (raw data) dalam analisis bioinformatika.

**B3.** Tuliskan perintah untuk mengekstrak semua header dari `sequences.fasta` lalu menyimpannya ke file `headers.txt`.

---

> Sudah selesai? Cek jawabanmu di [`answer-key.md`](answer-key.md) dan hitung skormu!

*Kuis Pasca-Workshop · "Bash for Biological Data Analysis" · OmicsLite · 18 Juli 2026*
