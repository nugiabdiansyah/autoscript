docker build -t ubuntuwithnginx .
<br><br>
docker run --rm -p 2222:22 -d --name=ubuntuwithnginx ubuntuwithnginx
