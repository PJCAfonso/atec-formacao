#!/bin/bash
echo -e "\e[92m[1]\e[96m Update and Upgrade for last version of Kali, wait please...\e[0m"
sudo apt update
sudo apt full-upgrade -y

echo -e "\e[92m[2]\e[96m Installing Python 3.8, this will take a while...\e[0m"
sudo apt-get install build-essential checkinstall libreadline-gplv2-dev libncursesw5-dev libssl-dev \
    libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev
cd /opt

[-f /opt/Python-3.8.0.tgz] && sudo rm -rf Python-3*
sudo wget https://www.python.org/ftp/python/3.8.0/Python-3.8.0.tgz
sudo tar xzf Python-3.8.0.tgz
cd Python-3.8.0
sudo ./configure --enable-optimizations
sudo make install
cd /opt
sudo rm -f Python-3.8.0.tgz

echo -e "\e[92m[3]\e[96m Installing XFCE4, this will take a while, don't killed yourself!!! ;)\e[0m"
sudo apt install -y kali-desktop-xfce xfce4 xorg xrdp compton 
echo -e "\e[92m[4]\e[96m Configuring XRDP to listen on port 3390 (but not starting the service)...\e[0m"
sudo sed -i 's/port=3389/port=3390/g' /etc/xrdp/xrdp.ini

echo -e "\e[92m[5]\e[96m Adding some settings to ~./bashrc\e[0m"
echo '## enable xcfe launch in WSL

export DISPLAY=:0
export XDG_RUNTIME_DIR=~/runtime
export RUNLEVEL=3
LANG="pt_PT.utf8"' >> ~/.bashrc
export DISPLAY=:0

sudo echo '## enable xcfe launch in WSL
export DISPLAY=:0
export XDG_RUNTIME_DIR=~/runtime
export RUNLEVEL=3
LANG="pt_PT.utf8"' >> /root/.bashrc

echo -e "\e[92m[+]\e[96m Getting some more scripts\e[0m"
wget --no-hsts -O ~/start-xfce https://raw.githubusercontent.com/PJCAfonso/atec-formacao/master/X_Kali_wsl/start-xfce
wget --no-hsts -O ~/.xinitrc https://raw.githubusercontent.com/PJCAfonso/atec-formacao/master/X_Kali_wsl/.xinitrc
chmod +x ~/start-xfce ~/.xinitrc
ln -s ~/.xinitrc ~/.xsession
sudo cp ~/.xinitrc start-xfce /root/
sudo chown root:root /root/.xinitrc /root/start-xfce
sudo chmod 755 /root/.xinitrc /root/start-xfce
sudo ln -s /root/.xinitrc /root/.xsession

echo -e "\e[92m[+]\e[96m Changing default panel settings for xfce\e[0m"
sudo wget --no-hsts -O /etc/xdg/xfce4/panel/default.xml https://raw.githubusercontent.com/PJCAfonso/atec-formacao/master/X_Kali_wsl/default.xml
sudo wget --no-hsts -O /etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-session.xml https://raw.githubusercontent.com/PJCAfonso/atec-formacao/master/X_Kali_wsl/xfce4-session.xml

[!-d /etc/xdg/disabled-autostart ] && sudo mkdir /etc/xdg/disabled-autostart
[-f /etc/xdg/autostart/nm-applet.desktop ] && sudo mv /etc/xdg/autostart/nm-applet.desktop /etc/xdg/autostart/disabled-autostart/
echo
echo
echo -e "\e[92m[*]\e[96m This part of the installation is completed. \e[92mOnly one more thing to do:\e[0m"
echo
echo -e "\e[92m[*]\e[96m Please download and install VcXsrv X Server from here:\e[0m"
echo "    https://sourceforge.net/projects/vcxsrv/"
echo
echo
echo -e "\e[92m[*]\e[96m You can start WSL Kali-X via:\e[0m"
echo "    ~/start-xfce            #(as normal user)"
echo "    sudo /root/start-xfce   #(as root user)"
echo
echo

