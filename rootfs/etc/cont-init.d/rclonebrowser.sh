#!/bin/sh

set -e # Dừng nếu có lỗi

# 1. Đảm bảo các thư mục cần thiết tồn tại
mkdir -p /config/.config/rclone
mkdir -p /media
mkdir -p /downloads

# 2. Đồng bộ quyền sở hữu (ownership) theo USER_ID và GROUP_ID
# Hàm take-ownership được tích hợp sẵn trong jlesage/baseimage-gui
take-ownership /config
take-ownership /downloads

# 3. Phân quyền truy cập thư mục (tùy chọn)
chmod -R 775 /downloads

# Nếu có file rclone.conf sẵn, bảo đảm quyền đọc/ghi
if [ -f /config/.config/rclone/rclone.conf ]; then
    chmod 600 /config/.config/rclone/rclone.conf
fi