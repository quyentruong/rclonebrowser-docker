# ==========================================
# STAGE 1: BUILD RCLONE BROWSER (QT6)
# ==========================================
FROM alpine:3.24 AS builder

RUN apk add --no-cache \
    git \
    cmake \
    make \
    g++ \
    qt6-qtbase-dev \
    qt6-qtsvg-dev

WORKDIR /tmp
RUN git clone --depth 1 https://github.com/quyentruong/RcloneBrowser.git /tmp/RcloneBrowser

WORKDIR /tmp/RcloneBrowser/build
RUN cmake -DCMAKE_BUILD_TYPE=Release .. && \
    make -j$(nproc) && \
    make install

# ==========================================
# STAGE 2: RUNTIME TRÊN JLESAGE/BASEIMAGE-GUI
# ==========================================
FROM jlesage/baseimage-gui:alpine-3.24-v4

ARG TARGETARCH

RUN set-cont-env APP_NAME "Rclone Browser Qt6"

# 1. Cài các thư viện Qt6, font và công cụ cần thiết (curl, unzip, ca-certificates)
RUN add-pkg \
    qt6-qtbase \
    qt6-qtbase-x11 \
    qt6-qtsvg \
    libstdc++ \
    ttf-dejavu \
    font-noto \
    ca-certificates \
    curl \
    unzip

# 2. Tải và cài đặt Rclone phiên bản mới nhất từ trang chủ rclone.org
RUN set -x && \
    case "${TARGETARCH:-amd64}" in \
        "arm64") RCLONE_ARCH="arm64" ;; \
        "arm/v7") RCLONE_ARCH="arm-v7" ;; \
        *) RCLONE_ARCH="amd64" ;; \
    esac && \
    curl -fsSL "https://downloads.rclone.org/rclone-current-linux-${RCLONE_ARCH}.zip" -o /tmp/rclone.zip && \
    unzip /tmp/rclone.zip -d /tmp && \
    mv /tmp/rclone-*-linux-${RCLONE_ARCH}/rclone /usr/bin/rclone && \
    chmod 755 /usr/bin/rclone && \
    rm -rf /tmp/rclone*

# 3. Copy binary RcloneBrowser từ stage builder
COPY --from=builder /usr/local/bin/rclone-browser /usr/local/bin/rclone-browser

# 4. Copy startapp.sh và rootfs init scripts
COPY startapp.sh /startapp.sh
RUN chmod +x /startapp.sh

COPY rootfs/ /
RUN chmod -R +x /etc/cont-init.d/

VOLUME ["/config"]
VOLUME ["/media"]
VOLUME ["/downloads"]