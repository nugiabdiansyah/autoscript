# Nextcloud Installation script

Install your own Nextcloud server in less than 10 minutes.

- <b>Ubuntu 20.04</b> LTS [AMD x86_64] / <b>22.04 LTS</b> [AMD x86_64] / <b>Debian 11.x</b> [AMD x86_64]
  <br>Proxmox LXC-support<b><sup>new</sup></b><br>
  <small>(Be aware, Debian requires a Proxmox-option called 'nesting=1')</small><br>
- NGINX 1.2x from nginx
- Option: PHP 8.1 // PHP 8.0 // PHP 7.4
- Option: MariaDB // postgreSQL
- Option: Self-signed // Let's Encrypt certificates
- Option: Nextcloud Release 2x.y<br>
  <small>(Nextcloud Versions less than 24 aren't compatible with PHP 8.1, configurable php version!)</small>
- Option: Nextcloud Office/OnlyOffice
- etc...

<h2>INSTALLATION (Ubuntu/Debian):</h2>
<h3>Create User:</h3>
<code>su -
apt install -y sudo
adduser nugiabdiansyah
usermod -aG sudo nugiabdiansyah
exit</code>
<h3>Preparations:</h3>
!!! DO NOT USE ROOT AS SSH !!!<br>
<code>sudo -s</code><br>
<code>wget -c https://github.com/nugiabdiansyah/autoscript/raw/master/nextcloud/nextcloud-installation.sh</code><br>
<code>chmod +x nextcloud-installation.sh</code><br> <br>
<h3>Modify configuration variables:</h3></code>
<code>vi nextcloud-installation.sh</code><br> <br>
<code>NEXTCLOUDDATAPATH="/var/nc_data"</code><br>
<code>NEXTCLOUDADMINUSER="nugiabdiansyah"</code><br>
<code>NEXTCLOUDADMINUSERPASSWORD=$(openssl rand -hex 16)</code><br>
<code>NCRELEASE="latest-25.tar.bz2"</code><br>
<code>PHPVERSION="8.1"</code><br>
<code>NEXTCLOUDDNS="cloud.nugi.biz"</code><br>
<code>LETSENCRYPT="n"</code><br>
<code>NEXTCLOUDEXTIP=$(dig +short txt ch whoami.cloudflare @1.0.0.1)</code><br>
<code>MARIADBROOTPASSWORD=$(openssl rand -hex 16)</code><br>
<code>DATABASE="m"</code><br>
<code>NCDBUSER="ncdbuser"</code><br>
<code>NCDBPASSWORD=$(openssl rand -hex 16)</code><br>
<code>CURRENTTIMEZONE='Asia/Jakarta'</code><br>
<code>PHONEREGION='ID'</code><br>
<code>NEXTCLOUDOFFICE="n"</code><br>
<code>ONLYOFFICE="n"</code><br>
<code>UPLOADSIZE='10G'</code><br>
<code>REDISPASSWORD=$(openssl rand -hex 16)</code><br>
<code>FIREWALL="n"</code><br>

<h3>Installation:</h3>
<code>./nextcloud-installation.sh</code>
<h2>UNINSTALL:</h2>
If you want to re-install your server - please uninstall your software first.<br> <br>
<code>/home/nugiabdiansyah/Nextcloud-Installation/uninstall.sh</code><br>
<code>rm -f /home/nugiabdiansyah/Nextcloud-Installation/uninstall.sh</code><br> <br>
All data, databases and software from the previous installation will be removed. Afterwards you can re-run the installation script.<br>
<h2>RE-INSTALLATION:</h2>
<code>./nextcloud-installation.sh</code><br>
<h2>LOGFILE:</h2>
<code>vi /home/nugiabdiansyah/Nextcloud-Installation/install.log</code><br>

---

Copyright by Carsten Rieger IT-Services; https://www.c-rieger.de/ & Edited by Nugi Abdiansyah; https://nugi.biz/
