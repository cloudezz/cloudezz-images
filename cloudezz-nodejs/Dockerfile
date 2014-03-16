FROM cloudezz/base

MAINTAINER bbytes  "info@beyondbytes.co.in"

# Update packages
RUN apt-get update && apt-get -y upgrade

# Install some packages we need
RUN apt-get install -y curl
RUN apt-get install -y gettext-base

# Install Node.JS
RUN cd /usr/local && curl http://nodejs.org/dist/v0.10.22/node-v0.10.22-linux-x64.tar.gz | tar --strip-components=1 -zxf- && cd
RUN npm -g update npm

# Install Grunt client and forever
RUN npm install -g grunt-cli
RUN npm install -g forever

# add default cloudezz init shell script  
# The default is called only when the used defined init file is not there in /cloudezz/app/cloudezz-config/cloudezz-init.sh
RUN mkdir -p /opt/cloudezz-config
ADD default-cloudezz-init.sh /opt/cloudezz-config/default-cloudezz-init.sh
RUN chmod +x /opt/cloudezz-config/default-cloudezz-init.sh

EXPOSE 3000

CMD cd /opt/cloudezz-config && ./start.sh
