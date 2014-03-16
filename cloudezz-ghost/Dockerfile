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

RUN rm /usr/sbin/policy-rc.d

CMD cd /opt/cloudezz-config && ./start.sh
