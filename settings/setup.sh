apt-get update -qq

# Install Docker
apt-get install -qq --force-yes docker.io
ln -sf /usr/bin/docker.io /usr/local/bin/docker
sed -i ' -F _docker docker' /etc/bash_completion.d/docker.io
apt-get install curl -qq

# Build first Docker with Wintersmith
cd /vagrant && docker build -t wintersmith/wintersmith .
docker run -p 49160:8080 -d wintersmith/wintersmith
