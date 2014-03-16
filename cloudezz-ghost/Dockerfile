FROM cloudezz/nodejs

MAINTAINER bbytes  "info@beyondbytes.co.in"


# Install Ghost
RUN mkdir -p /cloudezz/app

RUN cd /cloudezz/app && wget https://ghost.org/zip/ghost-0.4.1.zip -O ghost.zip
RUN cd /cloudezz/app && unzip ghost.zip && rm -f ghost.zip
RUN cd /cloudezz/app && npm install --production

EXPOSE 2368

RUN rm /usr/sbin/policy-rc.d

CMD cd /opt/cloudezz-config && ./start.sh
