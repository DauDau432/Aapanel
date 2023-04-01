#! /bin/bash
# By DauDau
# https://github.com/DauDau432/AaPanel

#màu sắc
red(){
    echo -e "\033[31m\033[01m$1\033[0m"
}
green(){
    echo -e "\033[32m\033[01m$1\033[0m"
}
yellow(){
    echo -e "\033[33m\033[01m$1\033[0m"
}
blue(){
    echo -e "\033[34m\033[01m$1\033[0m"
}
purple(){
    echo -e "\033[35m\033[01m$1\033[0m"
}

# 1 Cài đặt aapanel
function aapanel-install(){
wget -O "/root/aapanel-install.sh" "http://www.aapanel.com/script/install_6.0_en.sh"
red " Cài đặt bảng điều khiển aapanel từ trang web chính thức."
bash "/root/aapanel-install.sh"
}

# 2 Cài đặt BTPanel
function bt-install(){  
wget -O "/root/bt-install.sh" "http://download.bt.cn/install/install_6.0.sh"
red " BTPanel đang được cài đặt từ trang web chính thức.."
bash "/root/bt-install.sh"
}

# 3 Hạ cấp tải xuống aapanel GitHub (phiên bản cuối cùng không có quảng cáo)
function downgrade-aapanel(){
wget -O "/root/LinuxPanel_EN-6.8.23.zip" "https://github.com/DauDau432/Aapanel/blob/main/LinuxPanel_EN-6.8.23.zip?raw=true"
red " Tải xuống hoàn tất, hạ cấp."
unzip LinuxPanel_EN-6.8.23.zip
cd /root/panel
wget -O "/root/panel/downgrade.sh" "https://raw.githubusercontent.com/DauDau432/Aapanel/main/downgrade.sh" 
bash "/root/panel/downgrade.sh"
red " Hạ cấp thành công."
rm /root/LinuxPanel_EN-6.8.23.zip /root/panel/ -rf
}

# 4 Bảng điều khiển chùa hạ cấp
function downgrade-bt(){
wget -O "/root/LinuxPanel-7.7.0.zip" "https://github.com/DauDau432/Aapanel/blob/main/LinuxPanel-7.7.0.zip?raw=true"
blue " Tải xuống hoàn tất, hạ cấp."
unzip LinuxPanel-7.7.0.zip
cd /root/panel
bash /root/panel/update.sh
red " hạ cấp thành công."
rm /root/LinuxPanel-7.7.0.zip /root/panel/ -rf
sed -i "s|bind_user == 'True'|bind_user == 'Close'|" /www/server/panel/BTPanel/static/js/index.js
rm -f /www/server/panel/data/bind.pl
red " Xóa liên kết đã thành công."
}

# 5 bẻ khóa trả tiền 
function panel-happy(){
red " Vui lòng tự mở kho phần mềm một lần trước khi thực hiện"
sed -i 's|"endtime": -1|"endtime": 999999999999|g' /www/server/panel/data/plugin.json
sed -i 's|"pro": -1|"pro": 0|g' /www/server/panel/data/plugin.json
chattr +i /www/server/panel/data/plugin.json
chattr -i /www/server/panel/data/repair.json
rm /www/server/panel/data/repair.json
cd /www/server/panel/data
wget https://raw.githubusercontent.com/DauDau432/Aapanel/main/repair.json
chattr +i /www/server/panel/data/repair.json
red " Crack thành công."
}

# 6 làm sạch thùng rác
function clean-up-trash(){
rm -rf LinuxPanel_EN-6.8.23.zip aapanel-zh-CN.tar.gz chinese.zip aapanel-install.sh bt-install.sh bt-uninstall.sh
red " Dọn dẹp thành công."
red " Nếu bạn muốn xóa tập lệnh này, hãy chạy "rm -rf aapanel.sh"
}

# 7 Gỡ cài đặt bảng điều khiển
function uninstall(){
wget -O "/root/bt-uninstall.sh" "https://raw.githubusercontent.com/DauDau432/Aapanel/main/bt-uninstall.sh"
bash "/root/bt-uninstall.sh"
red " Đã gỡ cài đặt bảng điều khiển thành công."
}

# 8 Xóa tệp nhật ký và khóa tệp để ngăn ghi
function log(){
echo "" > /www/server/panel/script/site_task.py
chattr +i /www/server/panel/script/site_task.py
rm -rf /www/server/panel/logs/request/*
chattr +i -R /www/server/panel/logs/request
}

# menu
function start_menu(){
    clear
    echo ""
    purple " Cảm ơn bạn đã sử dụng công cụ aaPanel"
    purple " https://github.com/DauDau432/AaPanel"
    yellow " ————————————————————————————————————————————————"
    green " 1. Cài đặt aaPanel trên CentOS/Debian/Ubuntu"
    green " 2. Cài đặt BTPanel trên CentOS/Debian/Ubuntu"
    yellow " ————————————————————————————————————————————————"
    green " 3. Hạ cấp xuống phiên bản aaPanel 6.8.23"
    green " 4. Hạ cấp xuống phiên bản BTPanel 7.7.0"
    green " 5. Crack"
    green " 6. Xóa tệp nhật ký, khóa quyền ghi tệp"
    yellow " ————————————————————————————————————————————————"
    green " 7. Gỡ cài đặt bảng điều khiển aaPanel"
    green " 8. Script dọn dẹp tạo tập tin rác"
    green " 0. Thoát"

    echo
    read -p " Vui lòng nhập số: " menuNumberInput
    case "$menuNumberInput" in
        1 )
           aapanel-install
	    ;;
        2 )
           bt-install
        ;;
        3 )
           downgrade-aapanel
        ;;
        4 )
           downgrade-bt
        ;;
        5 )
           panel-happy
        ;;
        6 )
           log
        ;;
        7 )
           uninstall
        ;;
        8 )
           clean-up-trash
        ;;
        0 )
            exit 1
        ;;
        * )
            clear
            red " Vui lòng nhập số chính xác!"
            start_menu
        ;;
    esac
}
start_menu "first"
