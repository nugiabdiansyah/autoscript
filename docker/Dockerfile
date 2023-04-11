FROM ubuntu:focal

RUN ["apt-get", "update"]
RUN ["apt-get", "install", "-y", "nginx"]
RUN sed -i 's/Welcome to nginx!/Welcome to LKS 2023!/' /usr/share/nginx/html/index.html
RUN sed -i 's/Welcome to nginx!/Welcome to LKS 2023!/' /var/www/html/index.nginx-debian.html
RUN ["service", "nginx", "start"]

EXPOSE 80

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]