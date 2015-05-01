
Docker Pure-ftpd Server + Nginx/php-fpm  basic setup
============================
Simple Docker container integrating pureftpd server and a bascic nginx/php-fpm web server based on [phusions ubuntu base-image](https://github.com/phusion/baseimage-docker)

## Build Docker JIRA instance

    user@mainserver:~# sudo docker build -t="pureftp_nginx" .

## Run your JIRA docker instance
    
    user@mainserver:~# sudo docker run --name some_docker_ftp -d -p 10021:21 -p 10080:80 -p 30000:30000 -p 30001:30001 -p 30002:30002 -p 30003:30003 -p 30004:30004 -p 30005:30005 -p 30006:30006 -p 30007:30007 -p 30008:30008 -p 30009:30009 pureftp_nginx
    [...]
    fab2e64daa91
    user@mainserver:~#

We are using nginx reverse proxy in front to control ports and instances, feel free to change them following your need.

## Add a ftp-vhost user

Once the docker ftp instance is running, you can connect to it with `docker exec` or by ssh-ing into it. Then you can launch the add ftp vhost script from the /root/ directory. It basically create an account for a user and create a vhost to the nginx server inside your docker instance.

    # connect to the docker instance
    user@mainserver:~# sudo docker exec -it fab2e64daa91 "bash -l" 
    root@fab2e64daa91:/# cd 
    root@fab2e64daa91:~#
    
    # run the `add_ftp_host.sh` user script
    root@fab2e64daa91:~# ./add_ftp_host.sh "someftpuser" "somewherein.somedomain.com"
