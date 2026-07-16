# 📖 Glosarium — Kamus Istilah

> Tenggelam di jargon? Halaman ini menjelaskan istilah teknis yang muncul di workshop, dengan bahasa sesederhana mungkin. Diurutkan agar mudah dicari.

---

## A–E

**Argument (Argumen)**
Informasi tambahan yang kamu berikan ke sebuah perintah. Di `ls data/`, kata `data/` adalah argumen. Di `grep ">" file.fasta`, `">"` dan `file.fasta` adalah argumen.

**Absolute path (Path absolut)**
Alamat lengkap sebuah file dari akar sistem, selalu dimulai dengan `/`. Contoh: `/home/user/data/seq.fasta`. Selalu menunjuk lokasi yang sama dari mana pun kamu berada.

**Bash**
*Bourne Again SHell* — program shell paling umum di Linux/macOS. "Bahasa" yang kamu pakai untuk memberi perintah ke komputer lewat terminal.

**BED**
Format file teks yang menyimpan koordinat region pada genom (kromosom, posisi awal, posisi akhir). Menggunakan sistem koordinat **0-based**.

**Command (Perintah)**
Instruksi yang kamu ketik ke terminal, misalnya `ls`, `cd`, `grep`. Komputer membaca dan menjalankannya.

**Command substitution**
Menyimpan hasil sebuah perintah ke dalam variabel atau perintah lain, dengan sintaks `$(...)`. Contoh: `TODAY=$(date)`.

**CLI (Command Line Interface)**
Antarmuka berbasis teks tempat kamu mengetik perintah, lawan dari GUI (antarmuka grafis dengan ikon & klik).

---

## F–L

**FASTA**
Format file teks untuk menyimpan sekuens DNA/RNA/protein. Setiap sekuens punya baris header yang dimulai dengan `>`, diikuti baris-baris sekuens.

**FASTQ**
Seperti FASTA tapi juga menyimpan **skor kualitas** tiap basa. Setiap read terdiri dari 4 baris: header (`@`), sekuens, pemisah (`+`), dan string kualitas.

**Flag / Option (Opsi)**
Pengubah perilaku perintah, biasanya diawali `-` atau `--`. Contoh: `-l` di `ls -l` membuat tampilan list panjang.

**GC content**
Persentase basa Guanin (G) dan Sitosin (C) dalam sebuah sekuens DNA. Indikator biologis penting (misal stabilitas DNA).

**GUI (Graphical User Interface)**
Antarmuka grafis dengan jendela, ikon, dan mouse — seperti File Explorer atau Finder. Lawan dari CLI.

**Header (FASTA/FASTQ)**
Baris pertama tiap entri yang berisi nama/deskripsi sekuens. Di FASTA diawali `>`, di FASTQ diawali `@`.

**Home directory**
Folder pribadimu, biasanya `/home/namamu` (Linux) atau `/Users/namamu` (macOS). Disingkat dengan simbol `~`.

**Kernel**
Inti sistem operasi yang berkomunikasi langsung dengan perangkat keras. Shell adalah perantara antara kamu dan kernel.

---

## M–R

**man page (Manual)**
Dokumentasi bawaan sebuah perintah. Ketik `man ls` untuk membaca manual `ls`. Tekan `q` untuk keluar.

**Pipe (`|`)**
Simbol yang menyalurkan output satu perintah menjadi input perintah berikutnya. Contoh: `cat file | grep "x" | sort`. "Pipa" yang menyambungkan perintah.

**Phred score**
Ukuran kualitas pembacaan basa pada sekuensing. Makin tinggi, makin akurat. Phred 30 = akurasi 99.9%.

**Prompt**
Teks di terminal yang menandakan komputer siap menerima perintah (biasanya berakhir dengan `$` atau `#`).

**Read (sekuensing)**
Satu fragmen sekuens hasil mesin sequencer. File FASTQ berisi ribuan hingga jutaan read.

**Redirection (`>`, `>>`)**
Mengalihkan output perintah ke file. `>` menimpa file, `>>` menambahkan ke akhir file.

**Relative path (Path relatif)**
Alamat file relatif terhadap posisimu sekarang, tidak diawali `/`. Contoh: `data/seq.fasta` berarti folder `data` di dalam direktori saat ini.

**Regex (Regular Expression)**
Pola untuk mencocokkan teks. Contoh: `^>` berarti "baris yang dimulai dengan `>`". Dipakai di `grep`, `sed`, `awk`.

---

## S–Z

**Script**
File teks berisi serangkaian perintah bash yang dijalankan berurutan. Untuk mengotomasi tugas berulang. Biasanya berekstensi `.sh`.

**Shebang (`#!`)**
Baris pertama script yang memberi tahu sistem program apa yang menjalankannya. Contoh: `#!/usr/bin/env bash`.

**Shell**
Program yang menerjemahkan perintah teksmu agar bisa dijalankan sistem operasi. Bash adalah salah satu jenis shell.

**stdin / stdout / stderr**
Tiga "saluran" standar: **stdin** (input, biasanya keyboard), **stdout** (output normal, biasanya layar), **stderr** (output error). Bisa dialihkan dengan redirection.

**Terminal**
Aplikasi/jendela tempat kamu mengetik perintah dan melihat hasilnya. "Pintu masuk" ke shell.

**Variable (Variabel)**
Wadah untuk menyimpan nilai (teks/angka) agar bisa dipakai ulang. Contoh: `NAMA="workshop"`, lalu dipanggil dengan `$NAMA`.

**Wildcard (`*`, `?`)**
Karakter pengganti untuk mencocokkan banyak file. `*.fasta` cocok dengan semua file berakhiran `.fasta`. `?` cocok satu karakter apa saja.

**WSL (Windows Subsystem for Linux)**
Fitur Windows yang memungkinkan menjalankan Linux (dan bash) di dalam Windows tanpa dual-boot.

---

## Simbol Penting

| Simbol | Nama | Arti |
|--------|------|------|
| `~` | tilde | Home directory |
| `/` | slash | Pemisah folder / akar sistem |
| `.` | dot | Direktori saat ini |
| `..` | dot-dot | Direktori parent (satu tingkat di atas) |
| `|` | pipe | Sambungkan output ke perintah berikutnya |
| `>` | redirect | Simpan output ke file (timpa) |
| `>>` | append | Tambahkan output ke file |
| `*` | asterisk/wildcard | Cocokkan apa saja |
| `$` | dollar | Awalan variabel / prompt user biasa |
| `#` | hash | Komentar (dalam script) / prompt root |
| `&` | ampersand | Jalankan di background |

---

*Glosarium · Workshop "Bash for Biological Data Analysis" · OmicsLite · 18 Juli 2026*
