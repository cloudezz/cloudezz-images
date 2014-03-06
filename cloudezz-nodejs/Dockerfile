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

EXPOSE 3000

ADD init.sh /opt/init.sh

CMD cd /opt && ./start.sh
