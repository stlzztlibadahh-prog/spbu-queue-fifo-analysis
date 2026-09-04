# spbu-queue-fifo-analysis
Analysis of the queueing system at SPBU 54.83203 using the FIFO method.

# Penerapan Sistem Antrian Pada Stasiun Pengisian Bahan Bakar Umum (SPBU) 54.83203 Jalan Majapahit Menggunakan Metode FIFO

![Language](https://img.shields.io/badge/Language-R-276DC3?logo=r&logoColor=white)
![Method](https://img.shields.io/badge/Method-M%2FG%2F2-success)
![Queue Discipline](https://img.shields.io/badge/Queue%20Discipline-FIFO-yellowgreen)
![Analysis](https://img.shields.io/badge/Analysis-Queueing%20System-orange)
![Location](https://img.shields.io/badge/Location-SPBU%2054.83203-blueviolet)

---

## 📖 Deskripsi Proyek

Repository ini memuat seluruh tahapan analisis sistem antrean pada Stasiun Pengisian Bahan Bakar Umum (SPBU) 54.83203 Jalan Majapahit, Kota Mataram. Penelitian dilakukan menggunakan data primer hasil observasi langsung terhadap waktu kedatangan, waktu pelayanan, dan waktu tunggu pelanggan.

Analisis dilakukan untuk mengidentifikasi pola kedatangan dan pelayanan, menentukan model sistem antrean, serta mengevaluasi kinerja sistem berdasarkan beberapa ukuran kinerja antrean. Berdasarkan hasil analisis, sistem memiliki dua fasilitas pelayanan dan dimodelkan sebagai sistem antrean M/G/2 dengan disiplin pelayanan First In First Out (FIFO). :contentReference[oaicite:1]{index=1}

---

## 📂 Struktur Repository

```text
spbu-queue-fifo-analysis/
│
├── README.md
├── spbu-queue-fifo-report.pdf
├── spbu-queue-fifo-presentation.pptx
├── spbu-queue-fifo-data.xlsx
└── queue-analysis.R
---

## 📄 Deskripsi File

| File | Deskripsi |
|---|---|
| `README.md` | Dokumentasi dan ringkasan proyek |
| `spbu-queue-fifo-report.pdf` | Laporan penelitian lengkap |
| `spbu-queue-fifo-presentation.pptx` | Materi presentasi penelitian |
| `spbu-queue-fifo-data.xlsx` | Data penelitian dan hasil perhitungan |
| `queue-analysis.R` | Syntax R untuk analisis data |

---

## 🔍 Tahapan Analisis

1. Pengumpulan data melalui observasi langsung
2. Analisis statistik deskriptif
3. Pengujian distribusi menggunakan Anderson–Darling
4. Identifikasi pola kedatangan dan waktu pelayanan
5. Penentuan model antrean M/G/2
6. Perhitungan parameter sistem antrean
7. Analisis ukuran kinerja sistem antrean
8. Evaluasi stabilitas sistem
9. Visualisasi hasil analisis menggunakan R

---

## 📊 Hasil Utama

Hasil analisis menunjukkan bahwa pola kedatangan pelanggan mengikuti distribusi eksponensial, sedangkan waktu pelayanan mengikuti distribusi umum. Dengan dua fasilitas pelayanan, sistem antrean dimodelkan sebagai **M/G/2** dengan disiplin pelayanan **First In First Out (FIFO)**.

Seluruh kondisi sistem berada dalam keadaan stabil dengan nilai utilisasi sistem kurang dari 1. Kondisi antrean panjang menunjukkan tingkat kedatangan dan waktu tunggu yang lebih tinggi dibandingkan kondisi antrean pendek.

---

## 🛠️ Tools

- **R**
- **RStudio**
- **Microsoft Excel**

---

