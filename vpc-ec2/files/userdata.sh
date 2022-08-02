#!/bin/bash
set -x
yum install -y httpd.x86_64
systemctl start httpd.service
systemctl enable httpd.service
echo "Hello World" > /var/www/html/index.html