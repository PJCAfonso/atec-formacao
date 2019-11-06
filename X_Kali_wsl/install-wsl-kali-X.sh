#!/bin/bash
echo -e "\e[92m[+]\e[96m Installing XFCE4, this will take a while\e[0m"
sudo apt update
sudo apt full-upgrade -y
sudo apt install -y kali-desktop-xfce xorg xrdp compton
echo -e "\e[92m[+]\e[96m Configuring XRDP to listen on port 3390 (but not starting the service)...\e[0m"
sudo sed -i 's/port=3389/port=3390/g' /etc/xrdp/xrdp.ini
echo -e "\e[92m[+]\e[96m Adding some settings to ~./bashrc\e[0m"
echo '## enable xcfe launch in WSL
export DISPLAY=:0
export XDG_RUNTIME_DIR=~/runtime
export RUNLEVEL=3
LANG="en_US.utf8"' >> ~/.bashrc
export DISPLAY=:0
sudo echo '## enable xcfe launch in WSL
export DISPLAY=:0
export XDG_RUNTIME_DIR=~/runtime
export RUNLEVEL=3
LANG="en_US.utf8"' >> /root/.bashrc
echo -e "\e[92m[+]\e[96m Getting some more scripts\e[0m"
wget --no-hsts -O ~/start-xfce https://raw.githubusercontent.com/PJCAfonso/atec-formacao/X-Kali-X/master/start-xfce
wget --no-hsts -O ~/.xinitrc https://raw.githubusercontent.com/PJCAfonso/atec-formacao/X-Kali-X/master/.xinitrc
chmod +x ~/start-xfce ~/.xinitrc
ln -s ~/.xinitrc ~/.xsession
sudo cp ~/.xinitrc start-xfce /root/
sudo chown root:root /root/.xinitrc /root/start-xfce
sudo chmod 755 /root/.xinitrc /root/start-xfce
sudo ln -s /root/.xinitrc /root/.xsession
echo -e "\e[92m[+]\e[96m Changing default panel settings for xfce\e[0m"
sudo wget --no-hsts -O /etc/xdg/xfce4/panel/default.xml https://raw.githubusercontent.com/PJCAfonso/atec-formacao/X-Kali-wsl/master/default.xml
sudo wget --no-hsts -O /etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-session.xml https://raw.githubusercontent.com/PJCAfonso/atec-formacao/X-Kali-wsl/master/xfce4-session.xml
sudo mkdir /etc/xdg/disabled-autostart
sudo mv /etc/xdg/autostart/nm-applet.desktop /etc/xdg/autostart/disabled-autostart/
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

