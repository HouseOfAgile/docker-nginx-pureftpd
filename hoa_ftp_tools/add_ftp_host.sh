#!/bin/bash
#!/bin/bash
set -x

# define the 2 parameters

[ -z $1 ] && echo "Give a name for your ftp instance (and  optionnaly a hosts)" && exit

name=$1
host=${2:-$1".localhost"}
path=/home/ftpusers/$name

# create FTP user
pure-pw useradd $name -u ftpuser -d /home/ftpusers/$name
pure-pw mkdb

#setup nginx vhost for this ftp instance
cat ./nginx_simple_vhost.conf| sed "s/__project_name__/$name/g;s#__project_path__#$path#g;s/__project_hosts__/$host/g"  > /etc/nginx/sites-available/project_$name.conf
ln -s /etc/nginx/sites-available/project_$name.conf /etc/nginx/sites-enabled/project_$name.conf

service nginx reload
