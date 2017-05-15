#!/bin/sh

# Database yang ingin kita backup 
# Pisahkan dengan spasi untuk tiap database
databases="mydb1 mydb2"

# Waktu saat ini
date=$(date +"%Y-%m-%d")

# User dan password dari database
# Gunakan root supaya lebih enak
user=username
pass=password

# Tempat menyimpan database
bPath="/var/backups/databases"
bServer=192.168.100.82
bPort=22

# Buat folder bPath diatas jika belum ada
if [ ! -d $bPath ]; then
    mkdir -p $bPath
fi

# Hapus file backup di bPath jika umurnya melebihi 3 hari
find $bPath/*.sql.gz -mtime +3 -exec rm {} \;

# Mulai membackup database
for db in $databases; do
    # Nama dari file backupnya
    file=$db-$date.sql.gz

    # Membackup database dengan mysqldump
    echo "Starting to dump the $db database as $file"
    mysqldump --user=$user --password=$pass $db | gzip -9 > $bPath/$file
done

    # Upload file ke Backup Server menggunakan rsync
    echo "Starting to upload to Backup server"
    rsync -avhHP --progress --delete-after -r -e "ssh -p $bPort" $bPath/ root@$bServer:$bPath
    echo "Backup selesai"

# Clear cache. Hanya untuk KVM, Xen 
# ataupun dedicated server
free -m && sync && echo 3 > /proc/sys/vm/drop_caches && echo "" && free -m
