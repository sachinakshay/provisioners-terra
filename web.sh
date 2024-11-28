#!/bin/bash
sudo yum install -y wget unzip httpd

sudo systemctl start httpd 
sudo systemctl enable httpd 

sudo wget -q https://www.tooplate.com/zip-templates/2096_individual.zip
sudo unzip -o 2096_individual.zip

sudo cp -r 2096_individual/* /var/www/html/ 

sudo systemctl restart httpd 