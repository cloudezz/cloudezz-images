FROM cloudezz/nodejs

MAINTAINER bbytes  "info@beyondbytes.co.in"

RUN apt-get install -y unzip

# Install Ghost
RUN mkdir -p /cloudezz/app

RUN wget https://ghost.org/zip/ghost-0.4.1.zip 
RUN unzip ghost-0.4.1.zip  -d /cloudezz/app
RUN rm -f ghost-0.4.1.zip
RUN cd /cloudezz/app && npm install --production

EXPOSE 2368

# add default cloudezz init shell script  
# The default is called only when the used defined init file is not there in /cloudezz/app/cloudezz-config/cloudezz-init.sh
RUN mkdir -p /opt/cloudezz-config
ADD default-cloudezz-init.sh /opt/cloudezz-config/default-cloudezz-init.sh
RUN chmod +x /opt/cloudezz-config/default-cloudezz-init.sh

RUN rm /usr/sbin/policy-rc.d

CMD cd /opt/cloudezz-config && ./start.sh
