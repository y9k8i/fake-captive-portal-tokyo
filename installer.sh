#!/bin/bash
# Script to install wifipumpkin3 with FlaskTokyo plugin by y9k8i and zer0-ne
# https://github.com/y9k8i/fake-captive-portal-tokyo
#
# WiFi-Pumpkin was developed by P0cL4bs Team CopyRight 2015-2017
#--------------------------------
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
txtbld=$(tput bold)
bldred=${txtbld}$(tput setaf 1)
bldblu=${txtbld}$(tput setaf 4)
txtrst=$(tput sgr0)
#--------------------------------

func_Banner(){
	echo
	echo '   ==============================='
	echo "   |$bldblu FlaskTokyo plugin Installer$txtrst |"
	echo '   ==============================='
	echo
}

usage(){
	echo "usage: ./installer.sh --install"
}

func_install(){
	cd $(dirname $0)/

	# Installation of os-level dependencies
	sudo apt install libssl-dev libffi-dev build-essential
	dist=$(tr -s ' \011' '\012' < /etc/issue | head -n 1)
	if [ "$dist" = "Debian" ] || [ "$dist" = "Ubuntu" ]; then
		sudo apt install python3.7-dev python3.7
	fi

	# Installation of PyQt5
	sudo apt install python3-pyqt5
	python3 -c "from PyQt5.QtCore import QSettings"
	if [ $? -ne 0 ]; then
		echo >&2 "[$red✘$txtrst] Failed to import PyQt5"
		exit 1
	else
		echo "[$green✔$txtrst] PyQt5 Installed"
	fi

	# Clone wifipumpkin3 and FlaskTokyo plugin
	git clone https://github.com/P0cL4bs/wifipumpkin3.git
	if [ ! -e wifipumpkin3 ]; then
		echo >&2 "[$red✘$txtrst] Failed to clone wifipumpkin3"
		exit 1
	fi

	# Installation of wifipumpkin3 with FlaskTokyo plugin
	cp FlaskTokyo.py wifipumpkin3/wifipumpkin3/plugins/captiveflask/
	cd wifipumpkin3
	sudo python3 setup.py install
	if [ $? -ne 0 ]; then
		echo >&2 "[$red✘$txtrst] Failed to install wifipumpkin3"
		exit 1
	else
		echo "[$green✔$txtrst] PyQt5 Installed"
	fi
	cd ../
	cp -R FlaskTokyo ~/.config/wifipumpkin3/config/templates

	# Modify Captive Portal plugins configuration
	sed -i '1,/^$/s/^$/FlaskTokyo=false\n/' ~/.config/wifipumpkin3/config/app/captive-portal.ini

	echo "[$green✔$txtrst] FlaskTokyo plugin and wifipumpkin3 installed with success"
	echo "[$green✔$txtrst] execute$bldred wifipumpkin3$txtrst in terminal"
	echo "[$green+$txtrst]$yellow Copyright (c) 2020 Marcos Bomfim (mh4x0f) - P0cL4bs Team$txtrst"
	echo "[$green+$txtrst]$yellow Copyright (c) 2020 y9k8i and zer0-ne All Rights Reserved.$txtrst"
	exit 0
}

func_Banner
case $1 in
	--install ) func_install
	;;
	* ) usage
	exit
esac
