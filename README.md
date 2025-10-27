# rclonebrowser-docker (Multi-architecture)

Docker container for RcloneBrowser supporting both amd64 and arm64 architectures.

**Forked from [romancin/rclonebrowser-docker](https://github.com/romancin/rclonebrowser-docker)**

Latest Image:
```bash
docker pull ghcr.io/quyentruong/rclonebrowser-docker:latest
```

Quick Start:
```bash
docker run -d --name=rclonebrowser \
-v /srv/rclone/config:/config \
-v /srv/rclone/media:/media \
-e GROUP_ID=0 -e USER_ID=0 -e TZ=UTC \
-p 5800:5800 \
-p 5900:5900 \
ghcr.io/quyentruong/rclonebrowser-docker:latest
```

For more info, check the base repo: [romancin/rclonebrowser-docker](https://github.com/romancin/rclonebrowser-docker).

## Features

- **Multi-architecture support:** Runs on both `amd64` and `arm64`.
- **Automated monthly builds:** Automatically rebuilt each month if a new rclone version is available.
- **Versioned images:** Images are tagged with both `latest` and the specific rclone version.
- **Bug fixes:** Incorporates [this fix](https://github.com/JanHellwig/RcloneBrowser/commit/639e077ae8f7b50e739f8ec32e1810cdebe18b52) from JanHellwig/RcloneBrowser.