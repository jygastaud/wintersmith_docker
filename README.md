wintersmith_docker
==================

Expose Wintersmith static site generator (http://wintersmith.io) preview nodejs server into a docker.

Currently, this is just a short try of playing with docker.

## Method 1 : Vagrant

### Pre-requis
Vagrant and Virtualbox installed in your local device.

### Let the magic happend

Into the root directory of the project, run 
```
vagrant up
```

That will use the setup.sh file include into settings directory and
* built an Ubuntu VM (using the Vagrantfile)
* installed [Docker.io](http://docker.com) using the Dockerfile
* run Nodejs server with [Wintersmith](http://wintersmith.io) new default site

### Try it
Once every thing run, you should be able to acces your website via ```http://localhost:8123```

## Method 2 : Docker

### Pre-requis
[Docker.io](http://docker.com) installed in your local device.

### Build Docker with Wintersmith
```
docker build -t wintersmith/wintersmith .
```

then

```
docker run -p 8123:8080 -d wintersmith/wintersmith
```

### Try it
Once every thing run, you should be able to acces your website via ```http://localhost:8123```
