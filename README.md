wintersmith_docker
==================

Expose Wintersmith static site generator (http://wintersmith.io) preview (which use a nodejs server) into a docker.

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
Once everything run, you should be able to acces your website via ```http://localhost:8123```

## Method 2 : Docker

### Pre-requis
[Docker.io](http://docker.com) installed in your local device.

### Build an Image with Nodejs and Wintersmith included.
```
docker build -t jygastaud/wintersmith .
```

You can now use wintersmith CLI on container run.

### Examples

#### Case 1
You **already have files** generated by wintersmith

Just run the following command in your terminal:
```
sudo docker run -v ${PWD}/www/<website root folder>:/www/<website root folder> -w /www/<website root folder> --name wintersmtih_preview -p 8123:8080 -d jygastaud/wintersmith preview
```

#### Case 2
You want to **generate** a site with wintersmith

1. Build a data container
```
docker run --rm --name wintersmtih_build -w /www -d jygastaud/wintersmith new <website root folder>
```

2. Use Volume from data container as
```
docker run --volumes-from=wintersmtih_build -w /www/<website root folder> --name wintersmtih_preview -p 8123:8080 -d jygastaud/wintersmith preview
```

3. Copy files from container
Currently, there is no simple and quick solution to copy the folder generated into the data container.
It should not work until [that issue](https://github.com/docker/docker/issues/1992) is open.

3.1 Current workaround
We recommand the [install and use nsenter](https://github.com/jpetazzo/nsenter#how-do-i-install-nsenter-with-this) to create a tar file outside de mount volume and be able to get it via the "docker cp" command.

```
nsenter --target $PID --mount --uts --ipc --net --pid -- /bin/bash -c "tar -cvzf /<archive name>.tar /www/<website root folder>"
```
then, copy the file generated.

```
docker cp wintersmtih_build:/www/<website root folder> <local path>
```

3.2 Futurs solutions
```
docker run --volumes-from=wintersmtih_build -v ${PWD}/www/site:/www/website -w /www/website --name wintersmtih_preview -p 8123:8080 -d jygastaud/wintersmith preview
```

OR

```
docker cp wintersmtih_build:/www/<website root folder> <local path>
```

### Try it
Once everything run, you should be able to acces your website via ```http://localhost:8123```
