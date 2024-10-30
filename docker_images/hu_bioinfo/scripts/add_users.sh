groupadd -g 1000 normal 
useradd -m -s /bin/bash -u 1000 -g 1000 user 
echo user:user | chpasswd

echo "user ALL=(ALL) ALL" >> /etc/sudoers