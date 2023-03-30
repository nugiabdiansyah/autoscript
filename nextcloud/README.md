*********************************************
       Carsten Rieger IT-Services
        https://www.c-rieger.de
*********************************************

# Nextcloud Installation script
E: Install your own Nextcloud server in less than 10 minutes.

* <b>Ubuntu 20.04</b> LTS [AMD x86_64] / <b>22.04 LTS</b> [AMD x86_64] / <b>Debian 11.x</b> [AMD x86_64]
<br>Proxmox LXC-support<b><sup>new</sup></b><br>
<small>(Be aware, Debian requires a Proxmox-option called 'nesting=1')</small><br>
* NGINX 1.2x from nginx
* Option: PHP 8.1 // PHP 8.0 // PHP 7.4
* Option: MariaDB // postgreSQL
* Option: Self-signed // Let's Encrypt certificates
* Option: Nextcloud Release 2x.y<br>
  <small>(Nextcloud Versions less than 24 aren't compatible with PHP 8.1, configurable php version!)</small>
* Option: Nextcloud Office/OnlyOffice
* etc...

<h2>INSTALLATION (Ubuntu/Debian):</h2>
<h3>E: Preparations:</h3>
<code>sudo -s</code><br>
<code>apt install -y git</code><br>
<code>git clone https://codeberg.org/criegerde/nextcloud-zero</code><br>
<code>cp nextcloud-zero/zero.sh .</code><br>
<code>chmod +x zero.sh</code><br> <br>
<h3>E: Modify configuration variables:</h3></code>
<code>nano zero.sh</code><br> <br>
<code>NEXTCLOUDDATAPATH="/data"</code><br>
<code>NEXTCLOUDADMINUSER="nc_admin"</code><br>
<code>NEXTCLOUDADMINUSERPASSWORD=$(openssl rand -hex 16)</code><br>
<code>NCRELEASE="latest.tar.bz2"</code><br>
<code>PHPVERSION="8.1"</code><br>
<code>NEXTCLOUDDNS="ihre.domain.de"</code><br>
<code>LETSENCRYPT="n"</code><br>
<code>NEXTCLOUDEXTIP=$(dig +short txt ch whoami.cloudflare @1.0.0.1)</code><br>
<code>MARIADBROOTPASSWORD=$(openssl rand -hex 16)</code><br>
<code>DATABASE="m"</code><br>
<code>NCDBUSER="ncdbuser"</code><br>
<code>NCDBPASSWORD=$(openssl rand -hex 16)</code><br>
<code>CURRENTTIMEZONE='Europe/Berlin'</code><br>
<code>PHONEREGION='DE'</code><br>
<code>NEXTCLOUDOFFICE="n"</code><br>
<code>ONLYOFFICE="n"</code><br>
<code>UPLOADSIZE='10G'</code><br>
<code>REDISPASSWORD=$(openssl rand -hex 16)</code><br>

<h3>Installation:</h3>
<code>./zero.sh</code>
<h2>D/E: DEINSTALLATION/UNINSTALL:</h2>
E: If you want to re-install your server - please uninstall your software first.<br> <br>
<code>/home/*benutzer*/Nextcloud-Installationsskript/uninstall.sh</code><br>
<code>rm -f /home/*benutzer*/Nextcloud-Installationsskript/uninstall.sh</code><br> <br>
E: All data, databases and software from the previous installation will be removed. Afterwards you can re-run the installation script.<br>
<h2>D/E: ERNEUTE INSTALLATION/RE-INSTALLATION:</h2>
<code>./zero.sh</code><br>
<h2>D/E: LOGDATEI/LOGFILE:</h2>
<code>nano /home/*benutzer*/Nextcloud-Installationsskript/install.log</code><br>

-----------------------------------------------------------------------------------

E: Further hardening, optimization and enhancement information can be found here:<br>&nbsp;<br>
https://www.c-rieger.de/nextcloud-installationsanleitung/<br>&nbsp;<br>
Carsten Rieger IT-Services
