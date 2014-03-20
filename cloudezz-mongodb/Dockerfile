FROM cloudezz/base

MAINTAINER bbytes  "info@beyondbytes.co.in"

# Install MongoDB.
ENV MONGO_VERSION 2.4.9

# Install MongoDB v2.4.9
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/10gen.list
RUN apt-get -qq update
RUN apt-get -qqy install mongodb-10gen=2.4.9 pwgen

VOLUME ["/data/db"]

# Expose ports.
# - 27017: process
# - 28017: http
EXPOSE 27017
EXPOSE 28017


# Add run scripts
ADD set_mongo_user_password.sh /opt/cloudezz-config/set_mongo_user_password.sh
RUN chmod +x /opt/cloudezz-config/set_mongo_user_password.sh

# add default cloudezz init shell script  
# The default is called only when the used defined init file is not there in /cloudezz/app/cloudezz-config/cloudezz-init.sh
ADD default-cloudezz-init.sh /opt/cloudezz-config/default-cloudezz-init.sh
RUN chmod +x /opt/cloudezz-config/default-cloudezz-init.sh

CMD cd /opt/cloudezz-config && ./start.sh




