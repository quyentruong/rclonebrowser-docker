#!/bin/sh

set -e # Dừng nếu có lỗi

# 1. Đảm bảo các thư mục cấu hình cần thiết tồn tại
mkdir -p /config/.config/rclone

# 2. Đồng bộ quyền sở hữu (ownership) theo USER_ID và GROUP_ID
# Hàm take-ownership được tích hợp sẵn trong jlesage/baseimage-gui
take-ownership /config

# Nếu người dùng có mount thêm các thư mục tùy chọn (downloads, shared, media)
for dir in /downloads /shared /media; do
    if [ -d "$dir" ]; then
        take-ownership "$dir"
    fi
done

# Nếu có file rclone.conf sẵn, bảo đảm quyền đọc/ghi
if [ -f /config/.config/rclone/rclone.conf ]; then
    chmod 600 /config/.config/rclone/rclone.conf
fi