#!/bin/bash
# This script sets up a basic web server on an Ubuntu instance
# It installs Apache, sets up a simple HTML page, and starts the Apache service
# Update package lists
sudo apt-get update -y
# Install Apache web server
sudo apt-get install -y apache2
sudo apt-get install -y curl
sudo apt-get upgrade -y
# set a Hostname variable
HOSTNAME=$(WebServer)
HTML_FILE="/var/www/html/index.html"
# Switch to root user
sudo hostnamectl set-hostname $HOSTNAME
sudo exec bash

#Fetch Metadata and set as a Tag
INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)
AVAILABILITY_ZONE=$(curl http://169.254.169.254/latest/meta-data/placement/availability-zone)
TIMESTAMP=$(date)

# Create a simple HTML page
sudo echo "<html><body><h1>Welcome to my Apache Web Server!</h1><p>This is instance <b>$INSTANCE_ID</b> running in <b>$AVAILABILITY_ZONE</b></p><p>Hostname: <b>$HOSTNAME</b></p><p>created with terraform Timestamp:<b>$TIMESTAMP</b></p></body></html>" > $HTML_FILE

# Start Apache service
sudo systemctl restart apache2
# Enable Apache to start on boot
sudo systemctl enable apache2