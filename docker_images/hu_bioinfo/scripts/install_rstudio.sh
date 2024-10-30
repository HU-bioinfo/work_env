echo 'DPKG::Options { "--force-confdef"; "--force-confnew"; }' > /etc/apt/apt.conf.d/99force-conf

apt-get install gdebi-core -y --no-install-recommends
wget -q https://download2.rstudio.org/server/jammy/amd64/rstudio-server-2024.04.2-764-amd64.deb 
gdebi -n rstudio-server-2024.04.2-764-amd64.deb 
# mkdir /etc/rstudio/
echo "www-port=8080" >> /etc/rstudio/rserver.conf
echo "server-user=root" >> /etc/rstudio/rserver.conf

apt-get remove gdebi-core -y
rm /rstudio-server-2024.04.2-764-amd64.deb 

# for install jupyter
apt-get install pipx -y --no-install-recommends

#wget https://download2.rstudio.org/server/jammy/amd64/rstudio-server-2024.04.2-764-amd64.deb -q
#mkdir ~/rstudio-server
#dpkg -x --force-confold ~/rstudio-server-2024.04.2-764-amd64.deb ~/rstudio-server/
#echo "www-port=8080" >> /etc/rstudio/rserver.conf
