groupadd -g 1000 normal 
useradd -m -s /bin/bash -u 1000 -g 1000 user 
passwd -d user

sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen 
sed -i '/ja_JP.UTF-8/s/^# //g' /etc/locale.gen
locale-gen 
echo $TZ > /etc/timezone 
ln -fs /usr/share/zoneinfo/$TZ /etc/localtime 
dpkg-reconfigure -f noninteractive tzdata 