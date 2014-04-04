FROM cloudezz/servicebase

MAINTAINER bbytes  "info@beyondbytes.co.in"

RUN apt-get update -qq && apt-get install -y mysql-server-5.5

ADD my.cnf /etc/mysql/conf.d/my.cnf
RUN chmod 664 /etc/mysql/conf.d/my.cnf

#setup mysql before starting like setting password etc 
ADD setup_mysql.sh /opt/cloudezz-config/setup_mysql.sh
RUN chmod +x /opt/cloudezz-config/setup_mysql.sh

ADD start_mysql.sh /opt/cloudezz-config/start_mysql.sh
RUN chmod +x /opt/cloudezz-config/start_mysql.sh

ADD mysql.conf /etc/supervisor/conf.d/

VOLUME ["/var/lib/mysql"]

EXPOSE 3306

CMD cd /opt/cloudezz-config && ./setup_mysql.sh && ./start.sh
