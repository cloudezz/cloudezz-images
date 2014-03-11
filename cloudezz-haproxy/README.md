HAProxy 1.5 image run by supervisord 

    sudo docker pull cloudezz/haproxy
    sudo docker run -p 80:80 -p 443:443 -p 9000:9000 cloudezz/haproxy
    or
    sudo docker run -d -t -p 80:80 -p 443:443 -p 9000:9000 -p 2222:22 -e ROOT_SSH_PASSWD=haproxy  cloudezz/haproxy
