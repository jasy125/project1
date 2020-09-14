#!/bin/bash

dbname=$1
dbquery=$2

sudo apt-get -y update

# Install Postgresql
sudo apt install -y postgresql postgresql-contrib

# Create db
sudo -i -u postgres createdb $dbname

# Import db
sudo -i -u postgres psql $dbname < "/tmp/postgres.sql"

# Install nginx docker
sudo curl -sSL https://get.docker.com/ | sh
sudo docker pull nginx

# Make html dir
sudo mkdir -p ~/docker-nginx/html

# Make html file with hostname
sudo touch ~/docker-nginx/html/index.html
sudo cat > ~/docker-nginx/html/index.html << EOF

<!DOCTYPE html>
<html>
  <head>
    <title>Terraform/Docker/Postgresql/Nginx</title>
  </head>
  <body>
    <h1>$(hostname -f)</h1>
EOF


sudo echo "<div style='padding:20px;'><p>" >> ~/docker-nginx/html/index.html

#Query database
sudo -i -u postgres psql -d "$dbname" -c "$dbquery" >> ~/docker-nginx/html/index.html

sudo echo "</p></div>" >> ~/docker-nginx/html/index.html

# Run Docker container
sudo docker run --name docker-nginx -p 80:80 -d -v ~/docker-nginx/html:/usr/share/nginx/html nginx


# Get Container Hostname and ID and write to index.html

sudo docker ps --format "Name: {{.Names}}\n\n" >> ~/docker-nginx/html/index.html
sudo docker ps --format "ContainerID: {{.ID}}" >> ~/docker-nginx/html/index.html

sudo echo "</body></html>" >> ~/docker-nginx/html/index.html
