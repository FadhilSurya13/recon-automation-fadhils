#!/bin/bash

# Fadhils
# Script otomatis untuk recon subdomain

INPUT="input/domains.txt"
SUBDOMAIN="output/all-subdomains.txt"
LIVE="output/live.txt"
LOG="logs/progress.log"
ERR="logs/errors.log"

# Buat folder jika belum ada
mkdir -p output logs

echo "[$(date)] Mulai recon..." | tee -a $LOG

# Loop setiap domain, cari subdomain, hapus duplikat
while read domain; do
    echo "[$(date)] Scanning: $domain" | tee -a $LOG
    subfinder -d $domain -silent 2>>$ERR | anew $SUBDOMAIN
done < $INPUT

# Cek host yang hidup
echo "[$(date)] Mengecek live hosts..." | tee -a $LOG
httpx -l $SUBDOMAIN -silent -status-code -title 2>>$ERR | tee $LIVE

# Tampilkan hasil akhir
echo ""
echo "Selesai!"
echo "Total subdomain : $(wc -l < $SUBDOMAIN)"
echo "Total live hosts: $(wc -l < $LIVE)"
echo "[$(date)] Selesai." | tee -a $LOG
