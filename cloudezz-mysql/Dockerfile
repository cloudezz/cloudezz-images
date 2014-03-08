FROM cloudezz/servicebase

MAINTAINER bbytes  "info@beyondbytes.co.in"

#create cloudezz user
RUN useradd cloudezz -s /bin/bash -m -g sudo -G sudo >/dev/null 2>/dev/null 

RUN apt-get update -qq && apt-get install -y mysql-server-5.5

ADD my.cnf /etc/mysql/conf.d/my.cnf
RUN chmod 664 /etc/mysql/conf.d/my.cnf
ADD start_mysql.sh /opt/start_mysql.sh
RUN chmod +x /opt/start_mysql.sh

VOLUME ["/var/lib/mysql"]

EXPOSE 3306

CMD cd /opt && ./start.sh
