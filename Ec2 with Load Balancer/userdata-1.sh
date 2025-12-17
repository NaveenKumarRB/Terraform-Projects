#!/bin/bash

#default variables for clarity
APACHE_PACKAGE="apache2"
APACHE_SERVICE="apache2"
HTML_FILE="/var/www/html/index.html"

#Change Hostname
sudo hostnamectl set-hostname WEBSERVER-1
sudo exec bash

#Fetch instance metadata
HOSTNAME=$(hostname)
INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)
AVAILABILITY_ZONE=$(curl http://169.254.169.254/latest/meta-data/placement/availability-zone)
TIMESTAMP=$(date)

#install apache

sudo apt update -y
sudo apt install $APACHE_PACKAGE -y
sudo systemctl restart $APACHE_SERVICE

#Create a custom HTML page
sudo echo "<html><body><h1>Welcome to my Apache Web Server!</h1><p>This is instance <b>$INSTANCE_ID</b> running in <b>$AVAILABILITY_ZONE</b></p><p>Hostname: <b>$HOSTNAME</b></p><p>Timestamp:<b>$TIMESTAMP</b></p></body></html>" > $HTML_FILE
sudo systemctl restart $APACHE_SERVICE
sudo systemctl start $APACHE_SERVICE
