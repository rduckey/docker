#!/bin/bash
#Install docker and docker compose on Ubuntu 22.04
#Docker
sudo apt update
sudo apt install ca-certificates curl gnupg lsb-release -y
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
if [ $? != 0 ]; then
    sudo chmod a+r /etc/apt/keyrings/docker.gpg
    sudo apt-get update
fi
sudo apt-get install docker-ce docker-ce-cli containerd.io
if [ "$USER" != "root" ]; then
    sudo usermod -aG docker "${USER}"
fi
#Docker Compose
declare -a paths=( "/usr/local/lib/docker/" "/usr/local/libexec/docker" "/usr/lib/docker/" "/usr/libexec/docker/" )
path="missing"
for i in "${paths[@]}" ;
do
    if -f "${paths[@]}"; then
        path="$i"
    fi
done
if "$path" == "missing"
    path="$HOME/.docker/cli-plugins"
    mkdir -p "$path"
fi
sudo curl -L
"https://github.com/docker/compose/releases/download/2.12.2/docker-compose-$(uname -s)-$(uname -m)" -o $path/docker-compose
sudo chmod +x $path/docker-compose
#Confirm Docker and Docker-Compose installation
if [ "$(docker --version)" ] ; then
    echo "Congratulations Docker has been sucessfully installed!"
else
    echo "Docker has failed to install"
fi
if [ "$(docker-compose --version)" ] ; then
    echo "Congratulations Docker-Compose has been sucessfully installed!"
else
    echo "Docker-Compose has failed to install!"
fi

