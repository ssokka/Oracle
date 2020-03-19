#!/bin/bash

### 오라클 클라우드 Ubuntu 18.04 Minimal 기본 설정 

echo '### Swap File 생성 / 설정'
sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo '/swapfile swap swap default 0 0' | sudo tee -a /etc/fstab
free -h
echo

echo '### 패키지 업데이트 / 업그레이드 / 청소'
sudo apt update -y && sudo apt upgrade -y && sudo apt autoremove -y
echo

echo '### nano / htop / bmon 설치'
sudo apt install nano htop bmon -y
echo

echo '### 시간대 설정'
sudo ln -fs /usr/share/zoneinfo/Asia/Seoul /etc/localtime
sudo apt install tzdata -y
echo

echo '### 시간 동기화'
CONF=/etc/systemd/timesyncd.conf
sudo sed -i 's/^#//g' $CONF && sudo sed -i 's/^NTP=/NTP=kr.pool.ntp.org/g' $CONF
timedatectl set-ntp true
sudo systemctl restart systemd-timesyncd.service
timedatectl
echo

echo '### 방화벽 정책 설정 - 모두 허용'
sudo apt install iptables-persistent -y
sudo iptables -F
sudo netfilter-persistent save
sudo netfilter-persistent reload
sudo iptables -L
echo

echo '### Docker 설치'
curl -fsSL https://get.docker.com | sudo sh
sudo usermod -aG docker $USER
echo

#echo '### Rclone 설치'
#sudo apt install unzip -y
#curl https://rclone.org/install.sh | sudo bash
#echo