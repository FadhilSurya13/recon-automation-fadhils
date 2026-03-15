# Recon-automation-fadhils

Build Your Own Recon Automation Tools

Recon Automation tools adalah pipeline recon otomatis yang digunakan untuk tujuan bug bounty dan pengujian penetrasi
Dimana pada penugasan ini akan di enumerasikan subdomain menggunakan subfinder, menghapus duplikasi hasil dengan anew, dan memfilter host yang aktif dengan httpx

Untuk Instalasinya kita memerlukan beberapa tahap, yaitu:
1. Instalasi pdtm
2. Install tools yang diperlukan melalui pdtm
3. install anew, subfinder, httpx
  go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
  go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
  go install -v github.com/tomnomnom/anew@latest
5. lalu verifikasi intalasi tersebut beserta check versi berapa yang kita gunakan

Cara menjalankan scriptnya yaitu:
1. Melakukan clone repository penugasan
2. Menambahkan Target Domains pada folder input
3. Mengedit script tersebut sehingga bisa di execute
4. Jalankan Scriptnya dengan perintah (./scripts/recon-auto.sh)

Contoh Input:
# Target Bug Bounty
tesla.com
github.com
shopify.com
hackerone.com
bugcrowd.com

Contoh Output :
shop.tesla.com
api.tesla.com
auth.tesla.com
gist.github.com
api.github.com
partners.shopify.com
http://shop.tesla.com [200] [Tesla Shop]
https://api.github.com [200] [GitHub API]
https://partners.shopify.com [301] []
https://www.hackerone.com [200] [HackerOne - The #1 Trusted Security Platform and Hacker Program]

Penjelasan Singkat Kode:
1. Header, untuk memberitahu sistem bahwa file ini adalah script bash
2. Variable, menyimpan path file input, output, dan log untuk mempermudah
3. Mkdir,  membuat Folder baru secara otomatis agar tidak terjadi error, dan aman dijalankan berkali-kali
4. Log awal (echo "[$(date)] Mulai recon..." | tee -a $LOG), untuk mencetak, penanggalan otomatis, dan mengirim hasil echo tanpa menghapus isi yang lama
5. Loop Subdomain, membaca file domains satu persatu, melakukan setiap perintah, mencari setiap subdomain dari domain tersebut, hasilnya dikirim ke anew. Anew hanya menyimpan subdomain yang belum pernah ada
6. Cek Live Host (httpx -l $SUBDOMAIN -silent -status-code -title 2>>$ERR | tee $LIVE), memastikan semua subdomain aktif dan menyimpan hasilnya ke live.txt
7. Tampilan ringkasan, menampilkan hasil temuan total subdomain dan live host

   
