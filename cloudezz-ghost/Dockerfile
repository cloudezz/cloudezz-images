FROM cloudezz/nodejs

MAINTAINER bbytes  "info@beyondbytes.co.in"

RUN apt-get install -y unzip

# Install Ghost
RUN mkdir -p /cloudezz/ghost

RUN wget https://ghost.org/zip/ghost-0.4.1.zip 
RUN unzip ghost-0.4.1.zip  -d /cloudezz/ghost
RUN rm -f ghost-0.4.1.zip
RUN cd /cloudezz/ghost && npm install --production
ADD config.js /cloudezz/ghost/config.js

EXPOSE 2368

VOLUME ["/cloudezz/ghost-override"]

#set the run mode as production
ENV NODE_ENV production

# add default cloudezz init shell script  
# The default is called only when the used defined init file is not there in /cloudezz/app/cloudezz-config/cloudezz-init.sh
ADD default-cloudezz-init.sh /opt/cloudezz-config/default-cloudezz-init.sh
RUN chmod +x /opt/cloudezz-config/default-cloudezz-init.sh

RUN rm /usr/sbin/policy-rc.d

CMD cd /opt/cloudezz-config && ./start.sh
