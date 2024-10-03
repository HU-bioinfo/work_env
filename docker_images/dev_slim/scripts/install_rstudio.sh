apt-get install gdebi-core -y
wget https://download2.rstudio.org/server/jammy/amd64/rstudio-server-2024.04.2-764-amd64.deb
gdebi -n rstudio-server-2024.04.2-764-amd64.deb 
echo "www-port=8080" >> /etc/rstudio/rserver.conf
