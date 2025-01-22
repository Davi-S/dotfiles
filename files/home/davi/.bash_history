uname -r
reboot
ping google.com
nmcli dev connect wifi HFDD_5G --ask
sudo systemctl enable --now networkmanager
sudo systemctl enable --now NetworkManager
nmcli dev connect wifi HFDD_5G --ask
nmcli dev wifi connect HFDD_5G --ask
ping google.com
ip addr show
pacman -Sy timeshift
sudo pacman -Sy timeshift
reboot
sudo timeshift --create --comments 'clean system install'
reboot
cat /proc/meminfo
cat /proc/swaps
swapon -s
swapon --show
clear
poweroff
pacman -Sy openssh
sudo pacman -Sy openssh
sudo systemctl enable --now sshd
clear
clear
export TERM=xterm
clear
sudo pacman -Sy git base-devel
git clone https://aur.archlinux.org/aconfmgr-git.git
cd aconfmgr-git
ls
makepkg -si
cd
rm -r aconfmgr-git
sudo rm -rf aconfmgr-git
ls 
cd .config/aconfmgr
ls
ls -A
aconfmgr
cd .config/aconfmgr
aconfmgr save
cd .config/aconfmgr
sl
ls
cd
cd .config
ls
cd aconfmgr
ls
echo 'IgnorePath "/swap/*"' >> 10-ignore.sh
ls
aconfmgr save
ls
clear
sudo timeshift --restore
sudo reboot
ssh
sudo pacman -Sy openssh
sudo systemctl enable --now sshd
clear
cd .config/aconfmgr
ls
nano 99-unsorted
nano 99-unsorted
nano 99-unsorted.sh
nano 99-unsorted.sh
clear 
export TERM=xterm
clear
sudo pacman -Sy git base-devel
clear
ls 
git clone https://aur.archlinux.org/aconfmgr-git.git
cd aconfmgr-git
makepkg -si
cd
ls -a
cd .config/aconfmgr
ls
cat 10-ignore.sh
aconfmgr save
ls
sudo pacman -Sy nano
ls
clear
ls
nano 10-ignore.sh
ls
rm -rf 99-unsorted.sh
rm -rf files
ls
aconfmgr save
ls
nano 50-misc.sh
ls
nano 50-misc.sh
rm -rf 99-unsorted.sh
ls
aconfmgr aplly
aconfmgr apply
ls
clear
ls 
ls
nano README.md
ls
clear
git init
git commit -a -m "first commit"
git config --global user.email "67160664+Davi-S@users.noreply.github.com"
git config --global user.name "Davi-S"
git commit -a -m "first commit"
git add .
git commit -a -m "first commit"
git branch -M main
git remote add origin https://github.com/Davi-S/dotfiles.git
git push -u origin main
clear
ls
aconfmgr save
nano 10-ignore.sh
clear
ls
clear
sudo timeshift --create --comments "after aconfmgr setup"
sudo timeshift --list
cat /etc/timeshift/timeshift.conf
cat /etc/timeshift/timeshift.config
ls /etc/timeshift/
cat /etc/timeshift/timeshift.json
nano /etc/timeshift/timeshift.json
sudo nano /etc/timeshift/timeshift.json
sudo timeshift --create --comments "after timeshift config"
sudo timeshift --list
sudo reboot
sudo timeshift --list
sudo nano /etc/timeshift/timeshift.json
export TERM=xterm
sudo nano /etc/timeshift/timeshift.json
sudo timeshift --create --comments "after timeshift config"
timeshift --list
sudo timeshift --list
sudo timeshift --create --comments "after timeshift config"
sudo nano /etc/timeshift/timeshift.json
sudo nano /etc/timeshift.json
sudo timeshift --list
clear
ls
sudo rm -rf aconfmgr-git
ls
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
paru -Sy
paru
aconfmgr save
cd
ls
rm -rf paru
cd .config/aconfmgr
ls
nano 99-unsorted.sh
nano 50-misc.sh
rm 99-unsorted.sh
ls
git add .
git status
git commit -m "add paru"
git push
clear
exit
clear 
export TERM=xterm
clear
sudo nano /etc/timeshift/timeshift.json
sudo nano /etc/timeshift/timeshift.json
cat /etc/fstab
sudo nano /etc/timeshift/timeshift.json
sudo timeshift --lsit
sudo timeshift --list
sudo timeshift --create --comments "after timeshift config"
clear
aconfmgr save
ls .config/aconfmgr
cat 99-unsorted

cd .config/aconfmgr
cat 99-unsorted.sh
nano 50-misc.sh
nano 50-misc.sh
rm 99-unsorted.sh
git status
git commit -a -m "update timeshift config"
git push
clear
nano 50-misc.sh
git commit -a -m "update timeshift config"
git push
clear
cd .config
ls
cd
.config
cd .config
ls
clear
nano kanata.kbd
ls
mkdir kanata
ls
mv kanata.kbd kanata
ls
cd kanata
ls
clear
cd ../aconfmgr
ls
aconfmgr save
ls
nano README.md
git commit -a -m
git commit -a -m "readme""
"
git pull
git commit -a -m "readme"
git push
clear
exit
poweroff
