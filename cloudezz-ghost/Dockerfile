FROM cloudezz/nodejs

MAINTAINER bbytes  "info@beyondbytes.co.in"


RUN mkdir -p /cloudezz/app

RUN wget -P /cloudezz/app http://ghost.org/archives/ghost-0.4.1.zip

WORKDIR /cloudezz/app

RUN unzip -uo ghost-0.4.1.zip 
RUN rm ghost-0.4.1.zip
RUN npm install --production

EXPOSE 2368

RUN rm /usr/sbin/policy-rc.d

CMD cd /opt/cloudezz-config && ./start.sh
