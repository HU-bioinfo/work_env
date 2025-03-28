#!/bin/bash

groupadd -g 1001 normal 
useradd -m -s /bin/bash -u 1001 -g 1001 user 
passwd -d user

sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen 
sed -i '/ja_JP.UTF-8/s/^# //g' /etc/locale.gen
locale-gen ja_JP.UTF-8
update-locale LANG=ja_JP.UTF-8
echo $TZ > /etc/timezone 
ln -fs /usr/share/zoneinfo/$TZ /etc/localtime 
dpkg-reconfigure -f noninteractive tzdata 