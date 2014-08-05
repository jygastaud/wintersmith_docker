# DOCKER-VERSION 0.9.1
FROM    phusion/baseimage:0.9.9

# Set correct environment variables.
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

RUN 	echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN		sudo apt-get update -qq
RUN		sudo apt-get install python-software-properties python g++ make software-properties-common -y -qq
# Nodejs containers
RUN 	sudo add-apt-repository ppa:chris-lea/node.js
RUN		sudo apt-get update -qq
RUN		sudo apt-get install nodejs -y -qq
RUN 	sudo npm config set registry http://registry.npmjs.org/
# Comment the above line if you run Dockerfile outside of the VM.
#RUN 	sudo ln -s /usr/bin/nodejs /usr/bin/node
RUN		sudo npm install wintersmith -g

VOLUME ["/www/site"]

# Bundle app source (only use for production)
#ADD ./www /www

# Launch Wintersmith preview (for dev mode)
WORKDIR /www/site

CMD ["wintersmith", "preview"]

EXPOSE  8080

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
