#!/bin/sh

# Đảm bảo thư mục lưu trữ cấu hình tồn tại
mkdir -p /config/.config/rclone

# Cấu hình môi trường cho Qt6 và rclone
export HOME=/config
export XDG_CONFIG_HOME=/config/.config
export RCLONE_CONFIG=/config/.config/rclone/rclone.conf
export QT_QPA_PLATFORM=xcb

# Khởi chạy binary
exec /usr/local/bin/rclone-browser