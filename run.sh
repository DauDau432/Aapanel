#! /bin/bash
function install(){
clear
echo "   1. Centos"
echo "   2. Ubuntu"
read -p "  Vui Lòng Nhập : " num

    case "${num}" in
        1) yum install -y wget && wget -O install.sh http://www.aapanel.com/script/install_6.0_en.sh && bash install.sh aapanel
        ;;
        2) wget -O install.sh http://www.aapanel.com/script/install-ubuntu_6.0_en.sh && sudo bash install.sh aapanel
        ;;
        *) install
        ;;
    esac
}
function crack(){
sed -i 's|"endtime": -1|"endtime": 999999999999|g' /www/server/panel/data/plugin.json
sed -i 's|"pro": -1|"pro": 0|g' /www/server/panel/data/plugin.json
chattr +i /www/server/panel/data/plugin.json
chattr -i /www/server/panel/data/repair.json
rm /www/server/panel/data/repair.json
cd /www/server/panel/data
wget https://ghproxy.com/https://raw.githubusercontent.com/AaronYES/aaPanel/main/resource/repair.json
chattr +i /www/server/panel/data/repair.json
}
function delete-log(){
echo "" > /www/server/panel/script/site_task.py
chattr +i /www/server/panel/script/site_task.py
rm -rf /www/server/panel/logs/request/*
chattr +i -R /www/server/panel/logs/request
}
function uninstall(){
wget -O "/root/bt-uninstall.sh" "http://download.bt.cn/install/bt-uninstall.sh"
bash "/root/bt-uninstall.sh"
}

function start_menu(){
    clear
    echo -e " 1. Install aaPanel"
    echo -e " 2. Crack"
    echo -e " 3. Delete Log"
    echo -e " 4. Uninstall aaPanel"

    read -p "Vui Lòng Chọn:" numrun
    case "$numrun" in
        1 )
           install
	    ;;
        2 )
           crack
        ;;
        3 )
           delete-log
        ;;
        4 )
           uninstall
        ;;
        
        * )
            clear
            start_menu
        ;;
    esac
}
start_menu "first"