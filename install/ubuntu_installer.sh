#!/bin/bash
#Install docker and docker compose on Ubuntu 22.04
#Docker
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce -y
sudo usermod -aG docker "${USER}"
#Docker Compose
declare -a paths=( "/usr/local/lib/docker/" "/usr/local/libexec/docker" "/usr/lib/docker/" "/usr/libexec/docker/" )
path="missing"
for i in "${var[@]}" ;
do
    if [ -f "${var[@]}" ]; then
        path="$i"
    fi
done
if [ "$path" == "missing" ]; then
    path="$HOME/.docker/cli-plugins"
    mkdir -p $HOME/.docker/cli-plugins/
fi
curl -SL https://github.com/docker/compose/releases/download/v2.13.0/docker-compose-linux-x86_64 -o $path/docker-compose
chmod +x ~/.docker/cli-plugins/docker-compose
#Confirm Docker and Docker-Compose installation
if [ "$(docker --version)" == 0 ] ; then
    echo "Congratulations Docker has been sucessfully installed!"
else
    echo "Docker has failed to install"
fi
if [ "$(docker-compose --version)" == 0 ] ; then
    echo "Congratulations Docker-Compose has been sucessfully installed!"
else
    echo "Docker-Compose has failed to install!"
fi

