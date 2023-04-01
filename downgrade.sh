#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
LANG=en_US.UTF-8

# tập lệnh hạ cấp aapanel

panel_path='/www/server/panel'

if [ ! -d $panel_path ];then
echo " Bảng điều khiển aapanel hiện chưa được cài đặt!"
exit 0;
fi

base_dir=$(cd "$(dirname "$0")";pwd)
if [ $base_dir = $panel_path ];then
echo " Lệnh hạ cấp không thể được thực thi từ thư mục gốc của bảng điều khiển!"
exit 0;
fi

if [ ! -d $base_dir/class ];then
echo " Không tìm thấy tệp hạ cấp!"
exit 0;
fi

rm -f $panel_path/*.pyc $panel_path/class/*.pyc
\cp -r -f $base_dir/. $panel_path/
/etc/init.d/bt restart
echo "===================================="
echo " hạ cấp hoàn tất!"
