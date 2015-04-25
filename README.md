
Docker Pure-ftpd Server + Nginx/php-fpm  basic setup
============================


    sudo docker build -t="pureftp_nginx" .
    
    sudo docker run --name some_docker_ftp -d -p 10021:21 -p 10080:80 -p 30000:30000 -p 30001:30001 -p 30002:30002 -p 30003:30003 -p 30004:30004 -p 30005:30005 -p 30006:30006 -p 30007:30007 -p 30008:30008 -p 30009:30009 pureftp_nginx
