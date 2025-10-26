#
# RcloneBrowser Dockerfile
#

FROM jlesage/baseimage-gui:alpine-3.22-v4

# Define build arguments
ARG RCLONE_VERSION=current
ARG TARGETARCH

# Define working directory.
WORKDIR /tmp

# Install Rclone Browser dependencies

RUN apk --no-cache add \
      ca-certificates \
      fuse \
      wget \
      qt5-qtbase \
      qt5-qtbase-x11 \
      libstdc++ \
      libgcc \
      dbus \
      xterm \
    && cd /tmp \
    && wget -q http://downloads.rclone.org/rclone-${RCLONE_VERSION}-linux-${TARGETARCH}.zip \
    && unzip /tmp/rclone-${RCLONE_VERSION}-linux-${TARGETARCH}.zip \
    && mv /tmp/rclone-*-linux-${TARGETARCH}/rclone /usr/bin \
    && rm -r /tmp/rclone* && \
    apk add --no-cache --virtual=build-dependencies \
        build-base \
        cmake \
        make \
        gcc \
        git \
        qt5-qtbase qt5-qtmultimedia-dev qt5-qttools-dev && \
# Compile RcloneBrowser
    git clone https://github.com/JanHellwig/RcloneBrowser.git /tmp && \
    mkdir /tmp/build && \
    cd /tmp/build && \
    cmake -DCMAKE_CXX_FLAGS="-Wno-error=deprecated-declarations" .. && \
    cmake --build . && \
    ls -l /tmp/build && \
    cp /tmp/build/build/rclone-browser /usr/bin  && \
    # cleanup
     apk del --purge build-dependencies && \
    rm -rf /tmp/*

# Generate and install favicons.
RUN \
    APP_ICON_URL=https://github.com/rclone/rclone/raw/master/graphics/logo/logo_symbol/logo_symbol_color_512px.png && \
    install_app_icon.sh "$APP_ICON_URL"

# Add files.
COPY rootfs/ /

RUN chmod +x /startapp.sh 
RUN chmod +x /etc/cont-init.d/rclonebrowser.sh

# Set environment variables.
ENV APP_NAME="RcloneBrowser" \
    SERVICES_GRACETIME=8000 \
    ENABLE_CJK_FONT=1

# Define mountable directories.
VOLUME ["/config"]
VOLUME ["/media"]

# Metadata.
LABEL \
      org.label-schema.name="rclonebrowser" \
      org.label-schema.description="Docker container for RcloneBrowser" \
      org.label-schema.vcs-url="https://github.com/quyentruong/rclonebrowser-docker" \
      org.label-schema.schema-version="1.0"
