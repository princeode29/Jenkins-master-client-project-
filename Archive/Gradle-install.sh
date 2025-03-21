#!/bin/bash
sudo apt update -y
sudo apt install openjdk-11-jdk -y
wget -c https://services.gradle.org/distributions/gradle-6.8.3-bin.zip -P /tmp
sudo apt install unzip -y
sudo unzip -d /opt/gradle /tmp/gradle-6.8.3-bin.zip
ls /opt/gradle
sudo wget -c https://raw.githubusercontent.com/awanmbandi/realworld-cicd-pipeline-project/jenkins-master-client-config/gradle.sh -P /etc/profile.d/
sudo chmod +x /etc/profile.d/gradle.sh
source /etc/profile.d/gradle.sh
gradle --version

## Provision Jenkins Master Access
sudo su
useradd jenkinsmaster -m
echo "jenkinsmaster:jenkinsmaster" | chpasswd  ## Ubuntu

## Enable Password Authentication and Authorization
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
systemctl restart sshd
echo "jenkinsmaster ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
chown -R jenkinsmaster:jenkinsmaster /opt

## Install git
apt install git -y