FROM cloudezz/servicebase

MAINTAINER bbytes  "info@beyondbytes.co.in"

RUN apt-get update -qq && apt-get install -y mysql-server-5.5

ADD my.cnf /etc/mysql/conf.d/mysql.cnf
RUN chmod 664 /etc/mysql/conf.d/mysql.cnf
ADD start_mysql.sh /opt/start_mysql.sh
RUN chmod +x /opt/start_mysql.sh

EXPOSE 3306

CMD cd /opt && ./start.sh
