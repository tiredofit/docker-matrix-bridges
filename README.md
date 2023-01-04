# github.com/tiredofit/matrix-bridges

[![GitHub release](https://img.shields.io/github/v/tag/tiredofit/matrix-bridges?style=flat-square)](https://github.com/tiredofit/matrix-bridges/releases/latest)
[![Build Status](https://img.shields.io/github/actions/workflow/status/tiredofit/docker-matrix-bridges/main.yml?branch=main&style=flat-square)](https://github.com/tiredofit/docker-matrix-bridges/actions)
[![Docker Stars](https://img.shields.io/docker/stars/tiredofit/matrix-bridges.svg?style=flat-square&logo=docker)](https://hub.docker.com/r/tiredofit/matrix-bridges/)
[![Docker Pulls](https://img.shields.io/docker/pulls/tiredofit/matrix-bridges.svg?style=flat-square&logo=docker)](https://hub.docker.com/r/tiredofit/matrix-bridges/)
[![Become a sponsor](https://img.shields.io/badge/sponsor-tiredofit-181717.svg?logo=github&style=flat-square)](https://github.com/sponsors/tiredofit)
[![Paypal Donate](https://img.shields.io/badge/donate-paypal-00457c.svg?logo=paypal&style=flat-square)](https://www.paypal.me/tiredofit)

## About

This will build a Docker Image for [Matrix-bridges](https://), A series of bridges to connect various social networks and instant message providers to a Matrix server.

## Maintainer

- [Dave Conroy](https://github.com/tiredofit/)

## Table of Contents

- [About](#about)
- [Maintainer](#maintainer)
- [Table of Contents](#table-of-contents)
- [Installation](#installation)
  - [Build from Source](#build-from-source)
  - [Prebuilt Images](#prebuilt-images)
    - [Multi Architecture](#multi-architecture)
- [Configuration](#configuration)
  - [Quick Start](#quick-start)
  - [Persistent Storage](#persistent-storage)
  - [Environment Variables](#environment-variables)
    - [Base Images used](#base-images-used)
    - [Container Options](#container-options)
    - [Facebook](#facebook)
  - [Networking](#networking)
- [Maintenance](#maintenance)
  - [Shell Access](#shell-access)
- [Support](#support)
  - [Usage](#usage)
  - [Bugfixes](#bugfixes)
  - [Feature Requests](#feature-requests)
  - [Updates](#updates)
- [License](#license)
- [References](#references)


## Installation
### Build from Source
Clone this repository and build the image with `docker build -t (imagename) .`

### Prebuilt Images
Builds of the image are available on [Docker Hub](https://hub.docker.com/r/tiredofit/matrix-bridges) and is the recommended method of installation.

```bash
docker pull tiredofit/matrix-bridges:(imagetag)
```
The following image tags are available along with their tagged release based on what's written in the [Changelog](CHANGELOG.md):

| Container OS | Tag       |
| ------------ | --------- |
| Alpine       | `:latest` |

#### Multi Architecture
Images are built primarily for `amd64` architecture, and may also include builds for `arm/v7`, `arm64` and others. These variants are all unsupported. Consider [sponsoring](https://github.com/sponsors/tiredofit) my work so that I can work with various hardware. To see if this image supports multiple architecures, type `docker manifest (image):(tag)`

## Configuration

### Quick Start

* The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the examples folder for a working [docker-compose.yml](examples/docker-compose.yml) that can be modified for development or production use.

* Set various [environment variables](#environment-variables) to understand the capabilities of this image.
* Map [persistent storage](#data-volumes) for access to configuration and data files for backup.

### Persistent Storage

The following directories are used for configuration and can be mapped for persistent storage.

| Directory             | Description   |
| --------------------- | ------------- |
| `/config`             | Configuration |
| `/data/`              | Data          |
| `/data/db`            | SQLite DB     |
| `/data/registrations` | Registrations |
| `/logs`               | Logs          |

* * *
### Environment Variables

#### Base Images used

This image relies on an [Alpine Linux](https://hub.docker.com/r/tiredofit/alpine) base image that relies on an [init system](https://github.com/just-containers/s6-overlay) for added capabilities. Outgoing SMTP capabilities are handlded via `msmtp`. Individual container performance monitoring is performed by [zabbix-agent](https://zabbix.org). Additional tools include: `bash`,`curl`,`less`,`logrotate`,`nano`,`vim`.

Be sure to view the following repositories to understand all the customizable options:

| Image                                                  | Description                            |
| ------------------------------------------------------ | -------------------------------------- |
| [OS Base](https://github.com/tiredofit/docker-alpine/) | Customized Image based on Alpine Linux |

#### Container Options

| Variable                          | Description                                  | Default                      |
| --------------------------------- | -------------------------------------------- | ---------------------------- |
| `CONFIG_PATH`                     |                                              | `/config/`                   |
| `DATA_PATH`                       |                                              | `/data/`                     |
| `DB_SQLITE_PATH`                  |                                              | `${DATA_PATH}/db/`           |
| `HOMESERVER_ADDRESS`              |                                              | `https://example.com`        |
| `HOMESERVER_DOMAIN`               |                                              | `example.com`                |
| `HOMESERVER_ENABLE_ASYNC_UPLOADS` |                                              | `false`                      |
| `HOMESERVER_HTTP_RETRY_COUNT`     |                                              | `4`                          |
| `HOMESERVER_SOFTWARE`             |                                              | `standard`                   |
| `HOMESERVER_TLS_VERIFY`           |                                              | `TRUE`                       |
| `LOG_LEVEL`                       | `INFO`, `WARN`, `ERROR`, `CRITICAL`, `DEBUG` | `INFO`                       |
| `LOG_PATH`                        |                                              | `/logs/`                     |
| `LOG_TYPE`                        | `CONSOLE`, `FILE`, `BOTH`                    | `FILE`                       |
| `MODE`                            | `ALL`,`FACEBOOK`                             |                              |
| `REGISTRATION_PATH`               |                                              | `${DATA_PATH}/registrations` |

#### Facebook

| Variable                                               | Description           | Default                                      |
| ------------------------------------------------------ | --------------------- | -------------------------------------------- |
| `FACEBOOK_ALLOW_INVITES`                               |                       | `FALSE`                                      |
| `FACEBOOK_ALLOW_MATRIX_LOGIN`                          |                       | `TRUE`                                       |
| `FACEBOOK_APPSERVER_ADDRESS`                           |                       | `http://localhost:${FACEBOOK_LISTEN_PORT}`   |
| `FACEBOOK_APPSERVICE_ID`                               |                       | `facebook`                                   |
| `FACEBOOK_BACKFILL_ENABLE`                             |                       | `TRUE`                                       |
| `FACEBOOK_BACKFILL_ENABLE_MSC2716`                     |                       | `FALSE`                                      |
| `FACEBOOK_BACKFILL_MAX_CONVERSATIONS`                  |                       | `20`                                         |
| `FACEBOOK_BACKFILL_SYNC_THREAD_DELAY`                  |                       | `5`                                          |
| `FACEBOOK_BACKFILL_UNREAD_HOURS_THRESHOLD`             |                       | `0`                                          |
| `FACEBOOK_BOT_AVATAR`                                  |                       | `mxc://maunium.net/ygtkteZsXnGJLJHRchUwYWak` |
| `FACEBOOK_BOT_DISPLAYNAME`                             |                       | `Facebook bridge bot`                        |
| `FACEBOOK_BOT_USERNAME`                                |                       | `facebookbot`                                |
| `FACEBOOK_BRIDGE_PRESENCE`                             |                       | `FALSE`                                      |
| `FACEBOOK_COMMAND_PREFIX`                              |                       | `!fb`                                        |
| `FACEBOOK_CONFIG_FILE`                                 |                       | `facebook.yaml`                              |
| `FACEBOOK_CONFIG_PATH`                                 |                       | `${CONFIG_PATH}`                             |
| `FACEBOOK_DATA_PATH`                                   |                       | `${DATA_PATH}/facebook/`                     |
| `FACEBOOK_DB_MAX_SIZE`                                 |                       | `10`                                         |
| `FACEBOOK_DB_MIN_SIZE`                                 |                       | `1`                                          |
| `FACEBOOK_DB_PORT`                                     |                       | `5432`                                       |
| `FACEBOOK_DB_SQLITE_FILE`                              |                       | `facebook.db`                                |
| `FACEBOOK_DB_SQLITE_PATH`                              |                       | `${DB_SQLITE_PATH}`                          |
| `FACEBOOK_DB_TYPE`                                     | `POSTGRESQL` `SQLITE` | `SQLITE`                                     |
| `FACEBOOK_DISABLE_BRIDGE_NOTICES                       |                       | `FALSE`                                      |
| `FACEBOOK_ENABLE_DELIVERY_ERROR_REPORTS`               |                       | `TRUE`                                       |
| `FACEBOOK_ENABLE_DELIVERY_RECEIPTS`                    |                       | `FALSE`                                      |
| `FACEBOOK_ENABLE_EPHEMERAL_EVENTS`                     |                       | `TRUE`                                       |
| `FACEBOOK_ENABLE_MANHOLE`                              |                       | `FALSE`                                      |
| `FACEBOOK_ENABLE_MESSAGE_STATUS_EVENTS`                |                       | `FALSE`                                      |
| `FACEBOOK_ENABLE_METRICS`                              |                       | `FALSE`                                      |
| `FACEBOOK_ENABLE_PUBLIC`                               |                       | `FALSE`                                      |
| `FACEBOOK_ENCRYPTION_ALLOW`                            |                       | `FALSE`                                      |
| `FACEBOOK_ENCRYPTION_ALLOW_KEY_SHARING`                |                       | `FALSE`                                      |
| `FACEBOOK_ENCRYPTION_APPSERVICE`                       |                       | `FALSE`                                      |
| `FACEBOOK_ENCRYPTION_DEFAULT`                          |                       | `FALSE`                                      |
| `FACEBOOK_ENCRYPTION_REQUIRE`                          |                       | `FALSE`                                      |
| `FACEBOOK_ENCRYPTION_ROTATION_ENABLE_CUSTOM`           |                       | `FALSE`                                      |
| `FACEBOOK_ENCRYPTION_ROTATION_MESSAGES`                |                       | `100`                                        |
| `FACEBOOK_ENCRYPTION_ROTATION_MILLISECONDS`            |                       | `604800000`                                  |
| `FACEBOOK_ENCRYPTION_VERIFY_LEVELS_RECEIVE`            |                       | `unverified`                                 |
| `FACEBOOK_ENCRYPTION_VERIFY_LEVELS_SEND`               |                       | `unverified`                                 |
| `FACEBOOK_ENCRYPTION_VERIFY_LEVELS_SHARE`              |                       | `cross-signed-tofu`                          |
| `FACEBOOK_FEDERATE_ROOMS`                              |                       | `TRUE`                                       |
| `FACEBOOK_GET_PROXY_API_URL`                           |                       | `null`                                       |
| `FACEBOOK_HOMESERVER_ADDRESS`                          |                       | `${HOMESERVER_ADDRESS}`                      |
| `FACEBOOK_HOMESERVER_DOMAIN`                           |                       | `${HOMESERVER_DOMAIN}`                       |
| `FACEBOOK_HOMESERVER_ENABLE_ASYNC_UPLOADS`             |                       | `${HOMESERVER_ENABLE_ASYNC_UPLOADS}`         |
| `FACEBOOK_HOMESERVER_HTTP_RETRY_COUNT`                 |                       | `${HOMESERVER_HTTP_RETRY_COUNT}`             |
| `FACEBOOK_HOMESERVER_MESSAGE_SEND_CHECKPOINT_ENDPOINT` |                       | `null`                                       |
| `FACEBOOK_HOMESERVER_SOFTWARE`                         |                       | `${HOMESERVER_SOFTWARE}`                     |
| `FACEBOOK_HOMESERVER_STATUS_ENDPOINT`                  |                       | `null`                                       |
| `FACEBOOK_HOMESERVER_TLS_VERIFY`                       |                       | `${HOMESERVER_TLS_VERIFY}`                   |
| `FACEBOOK_INVITE_OWN_PUPPET_TO_PM`                     |                       | `FALSE`                                      |
| `FACEBOOK_LISTEN_IP`                                   |                       | `0.0.0.0`                                    |
| `FACEBOOK_LISTEN_PORT`                                 |                       | `29319`                                      |
| `FACEBOOK_LOG_FILE`                                    |                       | `facebook.log`                               |
| `FACEBOOK_LOG_LEVEL`                                   |                       | `${LOG_LEVEL}`                               |
| `FACEBOOK_LOG_LEVEL_AIOHTTP`                           |                       | `${FACEBOOK_LOG_LEVEL}`                      |
| `FACEBOOK_LOG_LEVEL_MAU`                               |                       | `${FACEBOOK_LOG_LEVEL}`                      |
| `FACEBOOK_LOG_LEVEL_MAUFBAPI`                          |                       | `${FACEBOOK_LOG_LEVEL}`                      |
| `FACEBOOK_LOG_LEVEL_PAHO`                              |                       | `${FACEBOOK_LOG_LEVEL}`                      |
| `FACEBOOK_LOG_PATH`                                    |                       | `${LOG_PATH}`                                |
| `FACEBOOK_LOG_TYPE`                                    |                       | `${LOG_TYPE}`                                |
| `FACEBOOK_MANHOLE_SOCKET`                              |                       | `/var/tmp/manhole_bridge_facebook.socket`    |
| `FACEBOOK_MANHOLE_WHITELIST`                           |                       | `0`                                          |
| `FACEBOOK_MAX_BODY_SIZE`                               |                       | `1`                                          |
| `FACEBOOK_METRICS_LISTEN_PORT`                         |                       | `3200`                                       |
| `FACEBOOK_MUTE_BRIDGING`                               |                       | `FALSE`                                      |
| `FACEBOOK_PERIODIC_RECONNECT_ALWAYS`                   |                       | `FALSE`                                      |
| `FACEBOOK_PERIODIC_RECONNECT_INTERVAL`                 |                       | `-1`                                         |
| `FACEBOOK_PERIODIC_RECONNECT_MIN_CONNECTED_TIME`       |                       | `0`                                          |
| `FACEBOOK_PERIODIC_RECONNECT_MODE`                     |                       | `refresh`                                    |
| `FACEBOOK_PERMISSIONS_ADMIN`                           |                       | `@admin:example.com`                         |
| `FACEBOOK_PERMISSIONS_RELAY`                           |                       | `*`                                          |
| `FACEBOOK_PERMISSIONS_USER`                            |                       | `example.com`                                |
| `FACEBOOK_PUBLIC_EXTERNAL_URL`                         |                       | `https://example.com/public`                 |
| `FACEBOOK_PUBLIC_PREFIX`                               |                       | `/public`                                    |
| `FACEBOOK_PUBLIC_SHARED_SECRET`                        |                       | `generate`                                   |
| `FACEBOOK_RECONNECTION_FAIL_ACTION`                    |                       | `reconnect`                                  |
| `FACEBOOK_RECONNECTION_FAIL_WAIT`                      |                       | `0`                                          |
| `FACEBOOK_REGENERATE_REGISTRATION`                     |                       | `FALSE`                                      |
| `FACEBOOK_REGISTRATION_FILE`                           |                       | `facebook-registration.yaml`                 |
| `FACEBOOK_REGISTRATION_PATH`                           |                       | `${REGISTRATION_PATH}`                       |
| `FACEBOOK_RESEND_BRIDGE_INFO`                          |                       | `FALSE`                                      |
| `FACEBOOK_RESYNC_MAX_DISCONNECTED_TIME`                |                       | `5`                                          |
| `FACEBOOK_SANDBOX_MEDIA_DOWNLOAD`                      |                       | `FALSE`                                      |
| `FACEBOOK_SEGMENT_API_KEY`                             |                       | `null`                                       |
| `FACEBOOK_SYNC_DIRECT_CHAT_LIST`                       |                       | `FALSE`                                      |
| `FACEBOOK_SYNC_ON_STARTUP`                             |                       | `TRUE`                                       |
| `FACEBOOK_SYNC_UPDATE_AVATAR`                          |                       | `TRUE`                                       |
| `FACEBOOK_TAG_ONLY_ON_CREATE`                          |                       | `TRUE`                                       |
| `FACEBOOK_TEMPLATE_DISPLAYNAME`                        |                       | `{displayname} (FB)`                         |
| `FACEBOOK_TEMPLATE_DISPLAYNAME_PREFERENCE`             |                       | `name,first_name`                            |
| `FACEBOOK_TEMPLATE_USERNAME`                           |                       | `facebook_{userid}`                          |
| `FACEBOOK_TEMPORARY_DISCONNECT_NOTICES`                |                       | `FALSE`                                      |

# Whatsapp

| Variable | Description | Default |
| -------- | ----------- | ------- |


### Networking

| Port  | Protocol | Description      |
| ----- | -------- | ---------------- |
| 29319 | tcp      | Facebook Bridge  |
| 3200  | tcp      | Facebook Metrics |
| 29318 | tcp      | Whatsapp Bridge  |
| 9200  | tcp      | Whatsapp Metrics |

## Maintenance
### Shell Access

For debugging and maintenance purposes you may want access the containers shell.

```bash
docker exec -it (whatever your container name is) bash
```
## Support

These images were built to serve a specific need in a production environment and gradually have had more functionality added based on requests from the community.
### Usage
- The [Discussions board](../../discussions) is a great place for working with the community on tips and tricks of using this image.
- Consider [sponsoring me](https://github.com/sponsors/tiredofit) personalized support.
### Bugfixes
- Please, submit a [Bug Report](issues/new) if something isn't working as expected. I'll do my best to issue a fix in short order.

### Feature Requests
- Feel free to submit a feature request, however there is no guarantee that it will be added, or at what timeline.
- Consider [sponsoring me](https://github.com/sponsors/tiredofit) regarding development of features.

### Updates
- Best effort to track upstream changes, More priority if I am actively using the image in a production environment.
- Consider [sponsoring me](https://github.com/sponsors/tiredofit) for up to date releases.

## License
MIT. See [LICENSE](LICENSE) for more details.

## References

* <https://github.com/mautrix/facebook>
