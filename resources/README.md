# 📚 Sumber Belajar Tambahan

Kumpulan referensi pilihan untuk melanjutkan perjalanan belajar Bash dan Bioinformatika setelah workshop.

---

## 🐚 Bash & Linux

### Dokumentasi & Referensi
| Sumber | URL | Keterangan |
|--------|-----|-----------|
| GNU Bash Manual | https://www.gnu.org/software/bash/manual/ | Dokumentasi resmi Bash |
| Bash Reference (TLDP) | https://tldp.org/LDP/Bash-Beginners-Guide/html/ | Panduan pemula lengkap |
| Shell Scripting Tutorial | https://www.shellscript.sh/ | Tutorial praktis shell scripting |
| ExplainShell | https://explainshell.com/ | Jelaskan perintah Bash secara visual |
| SS64 Bash Reference | https://ss64.com/bash/ | Referensi cepat semua perintah Bash |

### Latihan Interaktif
| Platform | URL | Keterangan |
|----------|-----|-----------|
| OverTheWire: Bandit | https://overthewire.org/wargames/bandit/ | Gamifikasi belajar Linux/Bash |
| HackerRank Shell | https://www.hackerrank.com/domains/shell | Challenge Bash pemula–mahir |
| cmdchallenge | https://cmdchallenge.com/ | Tantangan one-liner Bash |

---

## 🧬 Bioinformatika

### Kursus Online
| Kursus | Platform | Keterangan |
|--------|----------|-----------|
| Bioinformatics Specialization | Coursera (UCSD) | 7 kursus lengkap algoritma bioinformatika |
| Introduction to Bioinformatics | edX | Gratis, sertifikat berbayar |
| Bioinformatics with Python | Udemy | Gabungan Python + bioinformatika |
| Rosalind | http://rosalind.info/ | Problem set bioinformatika interaktif |

### Tools Bioinformatika Penting
| Tool | Fungsi | Referensi |
|------|--------|-----------|
| FastQC | Quality control reads | https://www.bioinformatics.babraham.ac.uk/projects/fastqc/ |
| Trimmomatic | Trimming adapter & quality | http://www.usadellab.org/cms/?page=trimmomatic |
| BWA | Mapping reads ke referensi | https://github.com/lh3/bwa |
| SAMtools | Manipulasi file SAM/BAM | https://www.htslib.org/ |
| BEDTools | Operasi file BED | https://bedtools.readthedocs.io/ |
| BLAST+ | Sequence similarity search | https://blast.ncbi.nlm.nih.gov/doc/blast-help/ |
| HISAT2 | RNA-seq alignment | https://daehwankimlab.github.io/hisat2/ |
| Bioconductor | R packages bioinformatika | https://www.bioconductor.org/ |

### Database Biologi
| Database | URL | Keterangan |
|----------|-----|-----------|
| NCBI | https://www.ncbi.nlm.nih.gov/ | Pusat database biologi Amerika |
| Ensembl | https://www.ensembl.org/ | Genome browser & anotasi |
| UniProt | https://www.uniprot.org/ | Database protein |
| UCSC Genome Browser | https://genome.ucsc.edu/ | Visualisasi genom |
| KEGG | https://www.genome.jp/kegg/ | Pathway database |

---

## 📖 Buku Rekomendasi

| Judul | Penulis | Keterangan |
|-------|---------|-----------|
| **Bioinformatics Data Skills** | Vince Buffalo | Bash + Python untuk bioinformatika. **Wajib baca!** |
| **Bioinformatics Algorithms** | Compeau & Pevzner | Teori algoritma bioinformatika |
| **The Linux Command Line** | William Shotts | Linux untuk pemula, tersedia gratis online |
| **A Primer on Genomics** | Matthew Hahn | Pengenalan genomik modern |

> 💡 **Tip**: "Bioinformatics Data Skills" oleh Vince Buffalo sangat direkomendasikan — mencakup hampir semua yang ada di workshop ini dan lebih mendalam.

---

## 🌐 Komunitas

| Komunitas | Platform | Link |
|-----------|----------|------|
| Bioinformatics Stack Exchange | Stack Exchange | https://bioinformatics.stackexchange.com/ |
| r/bioinformatics | Reddit | https://www.reddit.com/r/bioinformatics/ |
| Bioconductor Support | Forum | https://support.bioconductor.org/ |
| SEQanswers | Forum | http://seqanswers.com/ |


---

## 🎓 Jalur Belajar Lanjutan

Setelah menguasai Bash, berikut rekomendasi jalur belajar:

```
Bash Dasar (Workshop ini)
        ↓
Python untuk Bioinformatika (BioPython)
        ↓
R untuk Analisis Data Omics (Bioconductor)
        ↓
    ┌───────────────┐
    ↓               ↓
Genomics         Transcriptomics
(WGS/WES)        (RNA-seq)
    ↓               ↓
Variant Calling  Differential Expression
(GATK/DeepVariant) (DESeq2/edgeR)
```

### Topik Lanjutan yang Disarankan

1. **Python + BioPython** — Parsing sequence, structure prediction, BLAST API
2. **R + Bioconductor** — RNA-seq analysis, single-cell analysis
3. **Workflow Managers** — Snakemake atau Nextflow untuk pipeline reprodusibel
4. **HPC / Cloud** — SLURM, AWS, Google Cloud untuk data besar
5. **Docker/Singularity** — Containerisasi untuk reprodusibilitas

---

## 📁 File Format Referensi

| Format | Ekstensi | Spesifikasi |
|--------|----------|-------------|
| FASTA | `.fa`, `.fasta` | https://www.ncbi.nlm.nih.gov/genbank/fastaformat/ |
| FASTQ | `.fq`, `.fastq` | https://en.wikipedia.org/wiki/FASTQ_format |
| SAM/BAM | `.sam`, `.bam` | https://samtools.github.io/hts-specs/SAMv1.pdf |
| BED | `.bed` | https://genome.ucsc.edu/FAQ/FAQformat.html#format1 |
| GFF/GTF | `.gff`, `.gtf` | https://gmod.org/wiki/GFF3 |
| VCF | `.vcf` | https://samtools.github.io/hts-specs/VCFv4.2.pdf |

---

*Workshop "Bash for Biological Data Analysis" · OmicsLite · 18 Juli 2026*
