# DOCKER-VERSION 0.9.1
FROM    ubuntu

RUN		sudo apt-get update -qq
RUN 	sudo apt-get install python-software-properties -y -qq
RUN 	sudo apt-get install nodejs npm -y -qq
RUN 	sudo apt-get install nodejs-legacy -y -qq

# Bundle app source
ADD ./www /www

# Install app dependencies
RUN sudo npm install wintersmith -g

# Create new site
WORKDIR /www
RUN wintersmith new site

# Launch Wintersmith preview
WORKDIR /www/site
CMD ["wintersmith", "preview"]

EXPOSE  8080
