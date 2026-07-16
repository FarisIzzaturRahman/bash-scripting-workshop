#!/usr/bin/env bash
# ============================================================
# SOLUSI Case Study 1: Analisis File FASTA
# Workshop Bash for Biological Data Analysis — OmicsLite 2026
#
# ⚠️  SPOILER ALERT! Coba kerjakan sendiri dulu sebelum buka ini!
#
# Penggunaan: bash solution.sh
# ============================================================

set -euo pipefail

# Temukan lokasi data relatif terhadap posisi script ini,
# agar bisa dijalankan dari mana saja (folder solutions/ atau case01/).
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ -f "$SCRIPT_DIR/../data/sequences.fasta" ]]; then
    FASTA="$SCRIPT_DIR/../data/sequences.fasta"   # dijalankan dari solutions/
else
    FASTA="data/sequences.fasta"                  # dijalankan dari folder case study
fi

echo "╔══════════════════════════════════════════════════════════╗"
echo "║   SOLUSI CASE STUDY 1: ANALISIS FILE FASTA              ║"
echo "║   Workshop Bash for Biological Data Analysis            ║"
echo "║   OmicsLite 2026                                        ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""

# ============================================================
# TASK 1: EKSPLORASI AWAL
# ============================================================
echo "════════════════════════════════════════════════════"
echo "  TASK 1: EKSPLORASI AWAL"
echo "════════════════════════════════════════════════════"

echo ""
echo "--- Informasi dasar file ---"
echo "Nama file : $FASTA"
echo "Ukuran    : $(du -sh "$FASTA" | cut -f1)"
echo "Total baris: $(wc -l < "$FASTA")"

echo ""
echo "--- 10 baris pertama ---"
head -10 "$FASTA"

# ============================================================
# TASK 2: ANALISIS HEADER
# ============================================================
echo ""
echo "════════════════════════════════════════════════════"
echo "  TASK 2: ANALISIS HEADER"
echo "════════════════════════════════════════════════════"

echo ""
echo "--- Semua header ---"
grep "^>" "$FASTA"

echo ""
echo "--- Jumlah total sequence ---"
SEQ_COUNT=$(grep -c "^>" "$FASTA")
echo "Total sequence: $SEQ_COUNT"

echo ""
echo "--- Daftar organisme unik ---"
grep "^>" "$FASTA" | cut -d '|' -f 2 | sort -u

echo ""
echo "--- Distribusi sequence per organisme ---"
echo "(Diurutkan dari terbanyak)"
grep "^>" "$FASTA" | cut -d '|' -f 2 | sort | uniq -c | sort -rn

echo ""
echo "--- Daftar nama gen ---"
grep "^>" "$FASTA" | cut -d '|' -f 3 | sort -u

# ============================================================
# TASK 3: ANALISIS NUKLEOTIDA
# ============================================================
echo ""
echo "════════════════════════════════════════════════════"
echo "  TASK 3: ANALISIS NUKLEOTIDA"
echo "════════════════════════════════════════════════════"

echo ""

# Ambil semua sequence (tanpa header dan spasi)
ALL_SEQ=$(grep -v "^>" "$FASTA" | tr -d '\n ')

# Total nukleotida
TOTAL_NT=${#ALL_SEQ}
echo "--- Total nukleotida ---"
echo "$TOTAL_NT bp"

# Hitung masing-masing basa
COUNT_A=$(echo "$ALL_SEQ" | tr -cd 'Aa' | wc -c)
COUNT_T=$(echo "$ALL_SEQ" | tr -cd 'Tt' | wc -c)
COUNT_G=$(echo "$ALL_SEQ" | tr -cd 'Gg' | wc -c)
COUNT_C=$(echo "$ALL_SEQ" | tr -cd 'Cc' | wc -c)
COUNT_N=$(echo "$ALL_SEQ" | tr -cd 'Nn' | wc -c)

echo ""
echo "--- Komposisi basa ---"
echo "A: $COUNT_A"
echo "T: $COUNT_T"
echo "G: $COUNT_G"
echo "C: $COUNT_C"
echo "N: $COUNT_N (ambiguous)"

# GC content
GC_COUNT=$(( COUNT_G + COUNT_C ))
AT_COUNT=$(( COUNT_A + COUNT_T ))

echo ""
echo "--- GC Content ---"
GC_PERCENT=$(echo "scale=2; $GC_COUNT * 100 / $TOTAL_NT" | bc)
AT_PERCENT=$(echo "scale=2; $AT_COUNT * 100 / $TOTAL_NT" | bc)
echo "GC content: $GC_PERCENT%"
echo "AT content: $AT_PERCENT%"

GC_RATIO=$(echo "scale=3; $GC_COUNT / $AT_COUNT" | bc)
echo "GC/AT ratio: $GC_RATIO"

# ============================================================
# TASK 4: FILTER SEQUENCE
# ============================================================
echo ""
echo "════════════════════════════════════════════════════"
echo "  TASK 4: FILTER SEQUENCE"
echo "════════════════════════════════════════════════════"

echo ""
echo "--- Ekstrak sequence Homo sapiens ---"

# Metode: iterasi per sequence, filter berdasarkan organisme
HUMAN_OUTPUT="human_sequences.fasta"
> "$HUMAN_OUTPUT"   # Buat file kosong

CURRENT_HEADER=""
CURRENT_SEQ=""

while IFS= read -r line; do
    if [[ "$line" == ">"* ]]; then
        # Simpan sequence sebelumnya jika match Homo sapiens
        if [ -n "$CURRENT_SEQ" ] && echo "$CURRENT_HEADER" | grep -q "Homo sapiens"; then
            echo "$CURRENT_HEADER" >> "$HUMAN_OUTPUT"
            echo "$CURRENT_SEQ" >> "$HUMAN_OUTPUT"
        fi
        CURRENT_HEADER="$line"
        CURRENT_SEQ=""
    else
        CURRENT_SEQ+="$line"
    fi
done < "$FASTA"

# Proses sequence terakhir
if [ -n "$CURRENT_SEQ" ] && echo "$CURRENT_HEADER" | grep -q "Homo sapiens"; then
    echo "$CURRENT_HEADER" >> "$HUMAN_OUTPUT"
    echo "$CURRENT_SEQ" >> "$HUMAN_OUTPUT"
fi

echo "Sequence Homo sapiens tersimpan di: $HUMAN_OUTPUT"
echo "Jumlah sequence Homo sapiens:"
grep -c "^>" "$HUMAN_OUTPUT" 2>/dev/null || echo "0"

echo ""
echo "--- Header sequence Homo sapiens ---"
grep "^>" "$HUMAN_OUTPUT" 2>/dev/null || echo "(tidak ada)"

# ============================================================
# TASK 5 (BONUS): ANALISIS PER SEQUENCE
# ============================================================
echo ""
echo "════════════════════════════════════════════════════"
echo "  BONUS: ANALISIS PER SEQUENCE"
echo "════════════════════════════════════════════════════"

echo ""
printf "%-5s %-45s %-15s %-8s %-8s\n" "No." "Header" "Organisme" "Panjang" "GC(%)"
printf "%-5s %-45s %-15s %-8s %-8s\n" "---" "---------------------------------------------" "---------------" "-------" "------"

SEQ_NUM=0
CURRENT_HEADER=""
CURRENT_SEQ=""
MAX_LEN=0
MIN_LEN=9999999
MAX_HEADER=""
MIN_HEADER=""

while IFS= read -r line; do
    if [[ "$line" == ">"* ]]; then
        # Proses sequence sebelumnya
        if [ -n "$CURRENT_SEQ" ]; then
            SEQ_NUM=$((SEQ_NUM + 1))
            SEQ_LEN=${#CURRENT_SEQ}
            GC=$(echo "$CURRENT_SEQ" | tr -cd 'GCgc' | wc -c)
            GC_PCT="N/A"
            if [ "$SEQ_LEN" -gt 0 ]; then
                GC_PCT=$(echo "scale=1; $GC * 100 / $SEQ_LEN" | bc)
            fi
            ORGANISM=$(echo "$CURRENT_HEADER" | cut -d '|' -f 2)
            SHORT_H=$(echo "${CURRENT_HEADER:0:43}" | sed 's/>//')

            printf "%-5s %-45s %-15s %-8s %-8s\n" \
                "$SEQ_NUM" ">${SHORT_H}" "${ORGANISM:0:13}" "$SEQ_LEN" "$GC_PCT%"

            # Cek max/min
            if [ "$SEQ_LEN" -gt "$MAX_LEN" ]; then
                MAX_LEN=$SEQ_LEN
                MAX_HEADER=$(echo "$CURRENT_HEADER" | cut -d '|' -f 3)
            fi
            if [ "$SEQ_LEN" -lt "$MIN_LEN" ]; then
                MIN_LEN=$SEQ_LEN
                MIN_HEADER=$(echo "$CURRENT_HEADER" | cut -d '|' -f 3)
            fi
        fi
        CURRENT_HEADER="${line}"
        CURRENT_SEQ=""
    else
        CURRENT_SEQ+="${line}"
    fi
done < "$FASTA"

# Proses sequence terakhir
if [ -n "$CURRENT_SEQ" ]; then
    SEQ_NUM=$((SEQ_NUM + 1))
    SEQ_LEN=${#CURRENT_SEQ}
    GC=$(echo "$CURRENT_SEQ" | tr -cd 'GCgc' | wc -c)
    GC_PCT=$(echo "scale=1; $GC * 100 / $SEQ_LEN" | bc)
    ORGANISM=$(echo "$CURRENT_HEADER" | cut -d '|' -f 2)
    SHORT_H=$(echo "${CURRENT_HEADER:0:43}" | sed 's/>//')
    printf "%-5s %-45s %-15s %-8s %-8s\n" \
        "$SEQ_NUM" ">${SHORT_H}" "${ORGANISM:0:13}" "$SEQ_LEN" "$GC_PCT%"

    if [ "$SEQ_LEN" -gt "$MAX_LEN" ]; then
        MAX_LEN=$SEQ_LEN
        MAX_HEADER=$(echo "$CURRENT_HEADER" | cut -d '|' -f 3)
    fi
    if [ "$SEQ_LEN" -lt "$MIN_LEN" ]; then
        MIN_LEN=$SEQ_LEN
        MIN_HEADER=$(echo "$CURRENT_HEADER" | cut -d '|' -f 3)
    fi
fi

echo ""
echo "--- Ringkasan ---"
echo "Sequence terpanjang: $MAX_LEN bp → $MAX_HEADER"
echo "Sequence terpendek : $MIN_LEN bp → $MIN_HEADER"

echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║   ✅ Case Study 1 Selesai!                              ║"
echo "╚══════════════════════════════════════════════════════════╝"
