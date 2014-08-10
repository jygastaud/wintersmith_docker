FROM ubuntu:14.04
MAINTAINER jygastaud

ENV	DEBIAN_FRONTEND noninteractive

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN	sudo apt-get update -qq
RUN	sudo apt-get install python-software-properties python g++ make software-properties-common -y -qq

# Nodejs
RUN sudo add-apt-repository ppa:chris-lea/node.js
RUN	sudo apt-get update -qq
RUN	sudo apt-get install nodejs -y -qq
RUN sudo npm config set registry http://registry.npmjs.org/
RUN	sudo npm install wintersmith -g

VOLUME ["/www"]

ENTRYPOINT ["wintersmith"]

EXPOSE 8080

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
