HAProxy image run by supervisord 

    sudo docker pull cloudezz/haproxy
    sudo docker run -p 80:80 -p 443:443 -p 9000:9000 cloudezz/haproxy
    
