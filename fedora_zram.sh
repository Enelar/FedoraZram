#!/bin/bash
# http://mystilleef.blogspot.ru/2011/10/enable-zram-in-fedora.html
if [ `whoami` != "root" ]; then
  echo "Sudo required"
  exit
fi
RED='\033[0;31m'
NC='\033[0m' # No Color
 
 
printf "${RED}Check&install required utility${NC}\n"
rpmqa=`rpm -qa`
echo $rpmqa | grep -qw wget || sudo yum install wget
echo $rpmqa | grep -qw tar || sudo yum install tar

printf "${RED}Instailing scripts${NC}\n"
cd /usr/sbin
wget https://raw.githubusercontent.com/Enelar/FedoraZram/master/zramstart
wget https://raw.githubusercontent.com/Enelar/FedoraZram/master/zramstat
wget https://raw.githubusercontent.com/Enelar/FedoraZram/master/zramstop
chmod +x zramstart zramstat zramstop

printf "${RED}Instailing service${NC}\n"
cd /etc/systemd/system
wget https://raw.githubusercontent.com/Enelar/FedoraZram/master/mkzram.service
systemctl enable mkzram.service
systemctl start mkzram.service
systemctl status mkzram.service
