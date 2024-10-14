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
sudo docker run -d --name sonar3 -p 9000:9000 sonarqube:lts-community
sudo docker start sonar3


# jenkins token squ_325182a4423e4c801fa20068336bbec48d8a8af1