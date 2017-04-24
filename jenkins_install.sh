#!/bin/bash
wget -qOC - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install jenkins
sudo apt-get update
sudo apt-get install jenkins

#if using jenkins.war
sudo useradd -m jenkins_user
cd /home/jenkins_user
sudo wget http://mirrors.jenkins.io/war-stable/latest/jenkins.war /home/jenkins_user
sudo chown -R jenkins_user /home/jenkins_user/

#systemd service file
sudo echo '[Unit]
Description=Jenkins Daemon

[Service]
ExecStart=/usr/bin/java -jar /home/jenkins_user/jenkins.war
User=jenkins_user

[Install]
WantedBy=multi-user.target' > /etc/systemd/system/jenkins.service

#Note, if ufw is installed, be sure to allow default port 8080 access
