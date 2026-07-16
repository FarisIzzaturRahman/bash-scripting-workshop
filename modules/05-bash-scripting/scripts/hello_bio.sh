#!/usr/bin/env bash
# ============================================================
# Script  : hello_bio.sh
# Workshop: Bash for Biological Data Analysis — OmicsLite 2026
# Deskripsi: Script bash pertama kamu!
# Penggunaan: bash hello_bio.sh
# ============================================================

# Tampilkan header
echo "========================================================"
echo "   🧬 Selamat datang di Dunia Bioinformatika!           "
echo "   Workshop OmicsLite — Bash for Biological Data        "
echo "========================================================"
echo ""

# Informasi sistem
echo "📅 Tanggal     : $(date '+%Y-%m-%d %H:%M:%S')"
echo "👤 Pengguna    : $(whoami)"
echo "💻 Hostname    : $(hostname)"
echo "📁 Direktori   : $(pwd)"
echo "🐚 Bash versi  : $(bash --version | head -1 | cut -d' ' -f4)"
echo ""

# Cek tools bioinformatika yang tersedia
echo "🔧 Tools yang tersedia di sistem ini:"
for tool in grep awk sed cut sort uniq wc head tail cat tr; do
    if command -v "$tool" &> /dev/null; then
        echo "   ✅ $tool"
    else
        echo "   ❌ $tool (tidak ditemukan!)"
    fi
done
echo ""

# Simulasi "Hello World" bioinformatika
echo "🧬 Demo singkat — simulasi hitung sequence:"
DUMMY_FASTA=">seq1\nATCGATCG\n>seq2\nGCTAGCTA\n>seq3\nTACGTACG"
SEQ_COUNT=$(echo -e "$DUMMY_FASTA" | grep -c "^>")
echo "   File simulasi berisi: $SEQ_COUNT sequences"
echo ""

echo "========================================================"
echo "   ✅ Script berhasil! Kamu siap belajar bioinformatika!"
echo "========================================================"
