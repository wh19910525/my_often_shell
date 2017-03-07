

########################### Ubuntu 14.04 ########################

#install ssh
sudo apt-get install openssh-server -y

#install vim
sudo apt-get install vim -y

#install convert tools
sudo apt-get install imagemagick -y

#install mkimage ,for allwinner
sudo  apt-get install uboot-mkimage -y

#install p7zip
sudo  apt-get install p7zip -y

#install dos2unix 
sudo apt-get install dos2unix -y

#compile rk_sofia_3gr
sudo apt-get install lzop -y

#git read tools
sudo apt-get install tig -y


#install samba
sudo apt-get install samba -y
sudo apt-get install smbfs -y
sudo apt-get install system-config-samba -y
sudo apt-get install samba samba-common system-config-samba python-glade2 gksu -y
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf-bak
#this part add by frank at 2016.11.15, start
#[root_share]
#   comment = root share
#   path = /
#   writable = yes
#   guest ok = yes
#this part add by frank at 2016.11.15, end
sudo /etc/init.d/smbd restart

#install right key ,open termainal
sudo apt-get install nautilus-open-terminal -y

#ubuntu 14.04, def not install some lib and bin , so we install it
#ubuntu 14.04, def not install libz.so.1, so we install it
#apt-file search libz.so.1
sudo apt-get install lib32z1 -y
sudo apt-get install texinfo -y
sudo apt-get install libncurses-dev -y
sudo apt-get install libsdl-dev -y
sudo apt-get install libesd0-dev -y
sudo apt-get install valgrind -y
sudo apt-get install libgtk2.0-0:i386 -y
sudo apt-get install libpangox-1.0-0:i386 -y
sudo apt-get install libpangoxft-1.0-0:i386 -y
sudo apt-get install libidn11:i386 -y
sudo apt-get install gstreamer0.10-pulseaudio:i386 -y
sudo apt-get install gstreamer0.10-plugins-base:i386 -y
sudo apt-get install gstreamer0.10-plugins-good:i386 -y

#安装其他的软件
sudo apt-get install git-core gnupg flex bison gperf build-essential zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev  x11proto-core-dev libx11-dev   libxml2-utils tofrodos gawk python-lxml ant texinfo  xsltproc libxml++2.6-2 libxml2-dev libxml2 libxml2:i386 gawk python-commando lib32readline-gplv2-dev python-argparse lib32z1-dev lib32z-dev -y

#jdk 1.7
sudo add-apt-repository ppa:webupd8team/java -y
sudo apt-get update -y
sudo apt-get install openjdk-7-jdk -y



