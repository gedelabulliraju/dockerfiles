FROM almalinux:latest
LABEL maintainer="bulliraju"
RUN dnf install nginx -y
RUN rm -rf /usr/share/nginx/html/*
ADD age.rar /usr/share/nginx/html/
RUN chmod +x /usr/share/nginx/html/index.html
CMD ["nginx", "-g", "daemon off;"]
