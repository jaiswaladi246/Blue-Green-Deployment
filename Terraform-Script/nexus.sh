#!/bin/bash

sudo apt update -y
sudo apt install temurin-17-jdk -y
/usr/bin/java --version

#install docker
sudo apt-get update
sudo apt-get install docker.io -y
sudo usermod -aG docker ubuntu  
newgrp docker
sudo chmod 777 /var/run/docker.sock
sudo docker run -d --name nexus -p 8081:8081 sonatype/nexus3
sudo docker start nexus

