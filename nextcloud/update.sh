#!/bin/bash
apt update
DATABASE=postgresql
if dpkg-query -s $DATABASE 2>/dev/null|grep -q installed; then
    apt-mark unhold pgsql*
    apt-mark unhold postgresql*
else
    apt-mark unhold mariadb*
    apt-mark unhold mysql*
fi
apt-mark unhold nginx*
apt-mark unhold redis*
apt-mark unhold php*
apt upgrade -V
if dpkg-query -s $DATABASE 2>/dev/null|grep -q installed; then
    apt-mark hold pgsql*
    apt-mark hold postgresql*
else
    apt-mark hold mariadb*
    apt-mark hold mysql*
fi
apt-mark hold nginx*
apt-mark hold redis*
apt-mark hold mariadb*
apt-mark hold mysql*
apt-mark hold php*
apt autoremove
apt autoclean
chown -R www-data:www-data /var/www
find /var/www/nextcloud/ -type d -exec chmod 750 {} \;
find /var/www/nextcloud/ -type f -exec chmod 640 {} \;
if [ -d "/var/www/nextcloud/apps/notify_push" ]; then
sudo chmod ug+x /var/www/nextcloud/apps/notify_push/bin/x86_64/notify_push
fi
clear 
echo -n "Do you want to update Nextcloud [y|n]?"
read answer
if [ "$answer" != "${answer#[YyjJ]}" ] ;then
### privat
sudo -u www-data php /var/www/nextcloud/updater/updater.phar --no-backup
sudo -u www-data php /var/www/nextcloud/occ status
sudo -u www-data php /var/www/nextcloud/occ -V
sudo -u www-data php /var/www/nextcloud/occ db:add-missing-primary-keys
sudo -u www-data php /var/www/nextcloud/occ db:add-missing-indices
sudo -u www-data php /var/www/nextcloud/occ db:add-missing-columns
sudo -u www-data php /var/www/nextcloud/occ db:convert-filecache-bigint
sudo -u www-data sed -i "s/output_buffering=.*/output_buffering=0/" /var/www/nextcloud/.user.ini
clear 
echo -n "Would you like to update Nextcloud Apps [y|n]?"
read answer
if [ "$answer" != "${answer#[YyjJ]}" ] ;then
        sudo -u www-data php /var/www/nextcloud/occ app:update --all -v
else
    clear
    echo "Nextcloud Apps were not updated."
    echo ""
        fi
else
    clear
    echo "Nextcloud has not been updated/verified."
    echo ""
fi
clear
echo "Service are restarted..."
if dpkg-query -s $DATABASE 2>/dev/null|grep -q installed; then
    sudo systemctl restart postgresql.service redis-server.service php8.1-fpm.service nginx.service
else
    sudo systemctl restart mariadb.service redis-server.service php8.1-fpm.service nginx.service
fi
clear
if [ -e /var/run/reboot-required ]; then 
		echo "IT REQUIRES ***A SERVER RESTART***.";
        echo " "
		else
        clear
        echo "It is *** NO server restart *** necessary."
        echo " "
fi
exit 0
# Carsten Rieger, https://www.c-rieger.de
