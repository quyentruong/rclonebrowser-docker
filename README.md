# rclonebrowser-docker (Multi-architecture)

Docker container for RcloneBrowser supporting both amd64 and arm64 architectures.

**Forked from [romancin/rclonebrowser-docker](https://github.com/romancin/rclonebrowser-docker)**

Latest Image:
```bash
docker pull ghcr.io/ahbanavi/rclonebrowser-docker:latest
```

Quick Start:
```bash
docker run -d --name=rclonebrowser \
-v /srv/rclone/config:/config \
-v /srv/rclone/media:/media \
-e GROUP_ID=0 -e USER_ID=0 -e TZ=UTC \
-p 5800:5800 \
-p 5900:5900 \
ghcr.io/ahbanavi/rclonebrowser-docker:latest
```

For more info, check the base repos: [romancin/rclonebrowser-docker](https://github.com/romancin/rclonebrowser-docker).

## Features
- Multi-architecture support (amd64, arm64)
- Automated weekly builds (if new rclone version is available)
- Images are tagged with both `latest` and the specific rclone version
