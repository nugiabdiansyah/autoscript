#!/bin/sh

# Folder yang ingin kita backup
fName=("excellent.co.id server.excellent.co.id")

# Parent folder dari folder yang ingin kita backup
# Biasanya public_html
pFolder="/srv/www/htdocs"

# Local backup. Tempat dimana kita menaruh backup
# di webserver kita
bPath="/var/backups/files"
bServer=192.168.100.82
bPort=22

# Waktu sekarang
date=$(date +"%Y-%m-%d")

# Buat folder bPath diatas jika belum ada
if [ ! -d $bPath ]; then
    mkdir -p $bPath
fi

# Hapus file backup di bPath jika umurnya melebihi 3 hari
find $bPath/*.zip -mtime +3 -exec rm {} \;

# Mulai mambackup foldernya
for fd in $fName; do
    # Nama dari file backupnya
    file=$fd-$date.zip

    # Kita zip foldernya
    echo "Starting to zip the folder and files"
    cd $pFolder
    zip -r $bPath/$file $fd
done

    # Upload file ke Backup Server menggunakan rsync
    echo "Starting to upload to Backup server"
    rsync -avhHP --progress --delete-after -r -e "ssh -p $bPort" $bPath/ root@$bServer:$bPath
    echo "Backup selesai"

# Clear cache. Hanya untuk KVM, Xen 
# ataupun dedicated server
free && sync && echo 3 > /proc/sys/vm/drop_caches && echo "" && free
