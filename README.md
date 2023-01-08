# github.com/tiredofit/matrix-bridges

[![GitHub release](https://img.shields.io/github/v/tag/tiredofit/matrix-bridges?style=flat-square)](https://github.com/tiredofit/matrix-bridges/releases/latest)
[![Build Status](https://img.shields.io/github/actions/workflow/status/tiredofit/docker-matrix-bridges/main.yml?branch=main&style=flat-square)](https://github.com/tiredofit/docker-matrix-bridges/actions)
[![Docker Stars](https://img.shields.io/docker/stars/tiredofit/matrix-bridges.svg?style=flat-square&logo=docker)](https://hub.docker.com/r/tiredofit/matrix-bridges/)
[![Docker Pulls](https://img.shields.io/docker/pulls/tiredofit/matrix-bridges.svg?style=flat-square&logo=docker)](https://hub.docker.com/r/tiredofit/matrix-bridges/)
[![Become a sponsor](https://img.shields.io/badge/sponsor-tiredofit-181717.svg?logo=github&style=flat-square)](https://github.com/sponsors/tiredofit)
[![Paypal Donate](https://img.shields.io/badge/donate-paypal-00457c.svg?logo=paypal&style=flat-square)](https://www.paypal.me/tiredofit)

## About

This will build a Docker image of a series of bridges and bots to connect various social networks and instant message providers to a Matrix server.

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
    - [Discord](#discord)
    - [Facebook](#facebook)
    - [Google Chat](#google-chat)
    - [Instagram](#instagram)
    - [Signal](#signal)
    - [Slack](#slack)
    - [Telegram](#telegram)
    - [Twitter](#twitter)
    - [Whatsapp](#whatsapp)
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

#### Discord

Discord bridge provided by [Mautrix Discord Bridge](https://github.com/mautrix/discord)

| Variable                                              | Description | Default                                                    |
| ----------------------------------------------------- | ----------- | ---------------------------------------------------------- |
| `DISCORD_APPSERVICE_ID`                               |             | `discord`                                                  |
| `DISCORD_AUTOJOIN_THREAD_ON_OPEN`                     |             | `true`                                                     |
| `DISCORD_BOT_AVATAR`                                  |             | `mxc://maunium.net/NeXNQarUbrlYBiPCpprYsRqr`               |
| `DISCORD_BOT_DISPLAYNAME`                             |             | `Discord bridge bot`                                       |
| `DISCORD_BOT_USERNAME`                                |             | `discordbot`                                               |
| `DISCORD_COMMAND_PREFIX`                              |             | `!discord`                                                 |
| `DISCORD_CONFIG_FILE`                                 |             | `discord.yaml`                                             |
| `DISCORD_CONFIG_PATH`                                 |             | `${CONFIG_PATH}`                                           |
| `DISCORD_CONFIGURE_BRIDGE`                            |             | `TRUE`                                                     |
| `DISCORD_DATA_PATH`                                   |             | `${DATA_PATH}/discord/`                                    |
| `DISCORD_DISABLE_BRIDGE_NOTICES`                      |             | `FALSE`                                                    |
| `DISCORD_DOUBLE_PUPPET_ALLOW_DISCOVERY`               |             | `false`                                                    |
| `DISCORD_ENABLE_DELIVERY_ERROR_REPORTS`               |             | `TRUE`                                                     |
| `DISCORD_ENABLE_DELIVERY_RECEIPTS`                    |             | `FALSE`                                                    |
| `DISCORD_ENABLE_MESSAGE_STATUS_EVENTS`                |             | `FALSE`                                                    |
| `DISCORD_ENABLE_METRICS`                              |             | `FALSE`                                                    |
| `DISCORD_ENCRYPTION_ALLOW`                            |             | `FALSE`                                                    |
| `DISCORD_ENCRYPTION_ALLOW_KEY_SHARING`                |             | `FALSE`                                                    |
| `DISCORD_ENCRYPTION_APPSERVICE`                       |             | `FALSE`                                                    |
| `DISCORD_ENCRYPTION_DEFAULT`                          |             | `FALSE`                                                    |
| `DISCORD_ENCRYPTION_REQUIRE`                          |             | `FALSE`                                                    |
| `DISCORD_ENCRYPTION_ROTATION_ENABLE_CUSTOM`           |             | `FALSE`                                                    |
| `DISCORD_ENCRYPTION_ROTATION_MESSAGES`                |             | `100`                                                      |
| `DISCORD_ENCRYPTION_ROTATION_MILLISECONDS`            |             | `604800000`                                                |
| `DISCORD_ENCRYPTION_VERIFY_LEVELS_RECEIVE`            |             | `unverified`                                               |
| `DISCORD_ENCRYPTION_VERIFY_LEVELS_SEND`               |             | `unverified`                                               |
| `DISCORD_ENCRYPTION_VERIFY_LEVELS_SHARE`              |             | `cross-signed-tofu`                                        |
| `DISCORD_FEDERATE_ROOMS`                              |             | `TRUE`                                                     |
| `DISCORD_HOMESERVER_ADDRESS`                          |             | `${HOMESERVER_ADDRESS}`                                    |
| `DISCORD_HOMESERVER_DOMAIN`                           |             | `${HOMESERVER_DOMAIN}`                                     |
| `DISCORD_HOMESERVER_ENABLE_ASYNC_UPLOADS`             |             | `${HOMESERVER_ENABLE_ASYNC_UPLOADS}`                       |
| `DISCORD_HOMESERVER_HTTP_RETRY_COUNT`                 |             | `${HOMESERVER_HTTP_RETRY_COUNT}`                           |
| `DISCORD_HOMESERVER_MESSAGE_SEND_CHECKPOINT_ENDPOINT` |             | `null`                                                     |
| `DISCORD_HOMESERVER_SOFTWARE`                         |             | `${HOMESERVER_SOFTWARE}`                                   |
| `DISCORD_HOMESERVER_STATUS_ENDPOINT`                  |             | `null`                                                     |
| `DISCORD_HOMESERVER_TLS_VERIFY`                       |             | `${HOMESERVER_TLS_VERIFY}`                                 |
| `DISCORD_LISTEN_IP`                                   |             | `0.0.0.0`                                                  |
| `DISCORD_LISTEN_PORT`                                 |             | `29318`                                                    |
| `DISCORD_LOG_CONSOLE_JSON`                            |             | `FALSE`                                                    |
| `DISCORD_LOG_FILE`                                    |             | `discord.log`                                              |
| `DISCORD_LOG_FILE_JSON`                               |             | `FALSE`                                                    |
| `DISCORD_LOG_LEVEL`                                   |             | `${LOG_LEVEL}`                                             |
| `DISCORD_LOG_PATH`                                    |             | `${LOG_PATH}`                                              |
| `DISCORD_LOG_TYPE`                                    |             | `${LOG_TYPE}`                                              |
| `DISCORD_MANAGEMENT_ROOM_TEXT_ADDITIONAL_HELP`        |             | ``                                                         |
| `DISCORD_MANAGEMENT_ROOM_TEXT_WELCOME`                |             | `Hello, I'm a Discord bridge bot.`                         |
| `DISCORD_MANAGEMENT_ROOM_TEXT_WELCOME_CONNECTED`      |             | `Use \`help\` for help.`                                   |
| `DISCORD_MANAGEMENT_ROOM_TEXT_WELCOME_UNCONNECTED`    |             | `Use \`help\` for help or \`login\` to log in.`            |
| `DISCORD_METRICS_LISTEN_IP`                           |             | `127.0.0.1`                                                |
| `DISCORD_METRICS_LISTEN_PORT`                         |             | `9200`                                                     |
| `DISCORD_PERMISSIONS_ADMIN`                           |             | `@admin:example.com`                                       |
| `DISCORD_PERMISSIONS_RELAY`                           |             | `*`                                                        |
| `DISCORD_PERMISSIONS_USER`                            |             | `example.com`                                              |
| `DISCORD_PORTAL_MESSAGE_BUFFER`                       |             | `128`                                                      |
| `DISCORD_PRIVATE_CHAT_META`                           |             | `false`                                                    |
| `DISCORD_PROVISIONING_ENABLE`                         |             | `TRUE`                                                     |
| `DISCORD_PROVISIONING_PREFIX`                         |             | `/_matrix/provision`                                       |
| `DISCORD_REGISTRATION_FILE`                           |             | `discord-registration.yaml`                                |
| `DISCORD_REGISTRATION_PATH`                           |             | `${REGISTRATION_PATH}`                                     |
| `DISCORD_RESEND_BRIDGE_INFO`                          |             | `FALSE`                                                    |
| `DISCORD_RESTRICTED_ROOMS`                            |             | `true`                                                     |
| `DISCORD_STARTUP_PRIVATE_CHANNEL_CREATE_LIMIT`        |             | `5`                                                        |
| `DISCORD_SYNC_DIRECT_CHAT_LIST`                       |             | `true`                                                     |
| `DISCORD_TEMPLATE_DISPLAYNAME`                        |             | `{{.Username}}#{{.Discriminator}}{{if .Bot}} (bot){{end}}` |
| `DISCORD_TEMPLATE_GUILDNAME`                          |             | `'{{.Name}}'`                                              |
| `DISCORD_TEMPLATE_USERNAME`                           |             | `discord_{{.}}`                                            |

#### Facebook

Facebook bridge provided by [Mautrix Facebook Bridge](https://github.com/mautrix/facebook)

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
| `FACEBOOK_CONFIGURE_BRIDGE`                            |                       | `TRUE`                                       |
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

#### Google Chat

Google chat bridge provided by [Mautrix Google Chat Bridge](https://github.com/mautrix/googlechat)

| Variable                                                 | Description | Default                                      |
| -------------------------------------------------------- | ----------- | -------------------------------------------- |
| `GOOGLECHAT_APPSERVICE_ID`                               |             | `googlechat`                                 |
| `GOOGLECHAT_BOT_AVATAR`                                  |             | `mxc://maunium.net/NeXNQarUbrlYBiPCpprYsRqr` |
| `GOOGLECHAT_BOT_DISPLAYNAME`                             |             | `Google Chat bridge bot`                     |
| `GOOGLECHAT_BOT_USERNAME`                                |             | `googlechatbot`                              |
| `GOOGLECHAT_COMMAND_PREFIX`                              |             | `!gc`                                        |
| `GOOGLECHAT_CONFIG_FILE`                                 |             | `googlechat.yaml`                            |
| `GOOGLECHAT_CONFIG_PATH`                                 |             | `${CONFIG_PATH}`                             |
| `GOOGLECHAT_CONFIGURE_BRIDGE`                            |             | `TRUE`                                       |
| `GOOGLECHAT_DATA_PATH`                                   |             | `${DATA_PATH}/googlechat/`                   |
| `GOOGLECHAT_ENABLE_METRICS`                              |             | `FALSE`                                      |
| `GOOGLECHAT_ENCRYPTION_ALLOW`                            |             | `FALSE`                                      |
| `GOOGLECHAT_ENCRYPTION_ALLOW_KEY_SHARING`                |             | `FALSE`                                      |
| `GOOGLECHAT_ENCRYPTION_APPSERVICE`                       |             | `FALSE`                                      |
| `GOOGLECHAT_ENCRYPTION_DEFAULT`                          |             | `FALSE`                                      |
| `GOOGLECHAT_ENCRYPTION_REQUIRE`                          |             | `FALSE`                                      |
| `GOOGLECHAT_ENCRYPTION_ROTATION_ENABLE_CUSTOM`           |             | `FALSE`                                      |
| `GOOGLECHAT_DISABLE_BRIDGE_NOTICES`                      |             | `FALSE`                                      |
| `GOOGLECHAT_ENABLE_DELIVERY_ERROR_REPORTS`               |             | `TRUE`                                       |
| `GOOGLECHAT_ENABLE_DELIVERY_RECEIPTS`                    |             | `FALSE`                                      |
| `GOOGLECHAT_ENABLE_MESSAGE_STATUS_EVENTS`                |             | `FALSE`                                      |
| `GOOGLECHAT_ENCRYPTION_ROTATION_MESSAGES`                |             | `100`                                        |
| `GOOGLECHAT_ENCRYPTION_ROTATION_MILLISECONDS`            |             | `604800000`                                  |
| `GOOGLECHAT_ENCRYPTION_VERIFY_LEVELS_RECEIVE`            |             | `unverified`                                 |
| `GOOGLECHAT_ENCRYPTION_VERIFY_LEVELS_SEND`               |             | `unverified`                                 |
| `GOOGLECHAT_ENCRYPTION_VERIFY_LEVELS_SHARE`              |             | `cross-signed-tofu`                          |
| `GOOGLECHAT_FEDERATE_ROOMS`                              |             | `TRUE`                                       |
| `GOOGLECHAT_HANGOUTS_DEVICE_NAME`                        |             | `Mautrix-Google Chat Bridge`                 |
| `GOOGLECHAT_HOMESERVER_ADDRESS`                          |             | `${HOMESERVER_ADDRESS}`                      |
| `GOOGLECHAT_HOMESERVER_DOMAIN`                           |             | `${HOMESERVER_DOMAIN}`                       |
| `GOOGLECHAT_HOMESERVER_ENABLE_ASYNC_UPLOADS`             |             | `${HOMESERVER_ENABLE_ASYNC_UPLOADS}`         |
| `GOOGLECHAT_HOMESERVER_HTTP_RETRY_COUNT`                 |             | `${HOMESERVER_HTTP_RETRY_COUNT}`             |
| `GOOGLECHAT_HOMESERVER_MESSAGE_SEND_CHECKPOINT_ENDPOINT` |             | `null`                                       |
| `GOOGLECHAT_HOMESERVER_SOFTWARE`                         |             | `${HOMESERVER_SOFTWARE}`                     |
| `GOOGLECHAT_HOMESERVER_STATUS_ENDPOINT`                  |             | `null`                                       |
| `GOOGLECHAT_HOMESERVER_TLS_VERIFY`                       |             | `${HOMESERVER_TLS_VERIFY}`                   |
| `GOOGLECHAT_LISTEN_IP`                                   |             | `0.0.0.0`                                    |
| `GOOGLECHAT_LISTEN_PORT`                                 |             | `29318`                                      |
| `GOOGLECHAT_LOG_FILE`                                    |             | `googlechat.log`                             |
| `GOOGLECHAT_LOG_LEVEL`                                   |             | `${LOG_LEVEL}`                               |
| `GOOGLECHAT_LOG_PATH`                                    |             | `${LOG_PATH}`                                |
| `GOOGLECHAT_LOG_TYPE`                                    |             | `${LOG_TYPE}`                                |
| `GOOGLECHAT_METRICS_LISTEN_IP`                           |             | `127.0.0.1`                                  |
| `GOOGLECHAT_METRICS_LISTEN_PORT`                         |             | `9200`                                       |
| `GOOGLECHAT_PERMISSIONS_ADMIN`                           |             | `@admin:example.com`                         |
| `GOOGLECHAT_PERMISSIONS_RELAY`                           |             | `*`                                          |
| `GOOGLECHAT_PERMISSIONS_USER`                            |             | `example.com`                                |
| `GOOGLECHAT_PROVISIONING_ENABLE`                         |             | `TRUE`                                       |
| `GOOGLECHAT_PROVISIONING_PREFIX`                         |             | `/_matrix/provision`                         |
| `GOOGLECHAT_PROVISIONING_SEGMENT_KEY`                    |             | `null`                                       |
| `GOOGLECHAT_REGISTRATION_FILE`                           |             | `googlechat-registration.yaml`               |
| `GOOGLECHAT_REGISTRATION_PATH`                           |             | `${REGISTRATION_PATH}`                       |
| `GOOGLECHAT_RESEND_BRIDGE_INFO`                          |             | `FALSE`                                      |
| `GOOGLECHAT_TEMPLATE_DISPLAYNAME`                        |             | `googlechat_{userid}`                        |
| `GOOGLECHAT_TEMPLATE_USERNAME`                           |             | `googlechat_{userid}`                        |
| `GOOGLECHAT_UNIMPORTANT_BRIDGE_NOTICES`                  |             | `TRUE`                                       |

#### Instagram

Instagram bridge provided by [Mautrix Instagram Bridge](https://github.com/mautrix/instagram)

| Variable                                                | Description | Default                                      |
| ------------------------------------------------------- | ----------- | -------------------------------------------- |
| `INSTAGRAM_APPSERVICE_ID`                               |             | `instagram`                                  |
| `INSTAGRAM_BACKFILL_BACKOFF_MESSAGE_HISTORY`            |             | ``                                           |
| `INSTAGRAM_BACKFILL_BACKOFF_THREAD_LIST`                |             | `300`                                        |
| `INSTAGRAM_BACKFILL_DOUBLE_PUPPET`                      |             | `FALSE`                                      |
| `INSTAGRAM_BACKFILL_ENABLE`                             |             | `TRUE`                                       |
| `INSTAGRAM_BACKFILL_ENABLE_MSC2716`                     |             | `FALSE`                                      |
| `INSTAGRAM_BACKFILL_INCREMENTAL_MAX_PAGES`              |             | `10`                                         |
| `INSTAGRAM_BACKFILL_INCREMENTAL_MAX_TOTAL_PAGES`        |             | `-1`                                         |
| `INSTAGRAM_BACKFILL_INCREMENTAL_PAGE_DELAY`             |             | `5`                                          |
| `INSTAGRAM_BACKFILL_INCREMENTAL_POST_BATCH_DELAY`       |             | `20`                                         |
| `INSTAGRAM_BACKFILL_MAX_CONVERSATIONS`                  |             | `20`                                         |
| `INSTAGRAM_BACKFILL_SYNC_THREAD_DELAY`                  |             | `5`                                          |
| `INSTAGRAM_BACKFILL_UNREAD_HOURS_THRESHOLD`             |             | `0`                                          |
| `INSTAGRAM_BOT_AVATAR`                                  |             | `mxc://maunium.net/JxjlbZUlCPULEeHZSwleUXQv` |
| `INSTAGRAM_BOT_DISPLAYNAME`                             |             | `Instagram bridge bot`                       |
| `INSTAGRAM_BOT_USERNAME`                                |             | `instagrambot`                               |
| `INSTAGRAM_CAPTION_IN_MESSAGE`                          |             | `FALSE`                                      |
| `INSTAGRAM_COMMAND_PREFIX`                              |             | `!ig`                                        |
| `INSTAGRAM_CONFIG_FILE`                                 |             | `instagram.yaml`                             |
| `INSTAGRAM_CONFIG_PATH`                                 |             | `${CONFIG_PATH}`                             |
| `INSTAGRAM_CONFIGURE_BRIDGE`                            |             | `TRUE`                                       |
| `INSTAGRAM_DATA_PATH`                                   |             | `${DATA_PATH}/instagram/`                    |
| `INSTAGRAM_DISABLE_BRIDGE_NOTICES`                      |             | `FALSE`                                      |
| `INSTAGRAM_DISPLAYNAME_MAX_LENGTH`                      |             | `100`                                        |
| `INSTAGRAM_DOUBLE_PUPPET_ALLOW_DISCOVERY`               |             | `FALSE`                                      |
| `INSTAGRAM_ENABLE_BRIDGE_NOTICES`                       |             | `TRUE`                                       |
| `INSTAGRAM_ENABLE_DELIVERY_ERROR_REPORTS`               |             | `TRUE`                                       |
| `INSTAGRAM_ENABLE_DELIVERY_RECEIPTS`                    |             | `FALSE`                                      |
| `INSTAGRAM_ENABLE_MESSAGE_STATUS_EVENTS`                |             | `FALSE`                                      |
| `INSTAGRAM_ENABLE_METRICS`                              |             | `FALSE`                                      |
| `INSTAGRAM_ENCRYPTION_ALLOW`                            |             | `FALSE`                                      |
| `INSTAGRAM_ENCRYPTION_ALLOW_KEY_SHARING`                |             | `FALSE`                                      |
| `INSTAGRAM_ENCRYPTION_APPSERVICE`                       |             | `FALSE`                                      |
| `INSTAGRAM_ENCRYPTION_DEFAULT`                          |             | `FALSE`                                      |
| `INSTAGRAM_ENCRYPTION_REQUIRE`                          |             | `FALSE`                                      |
| `INSTAGRAM_ENCRYPTION_ROTATION_ENABLE_CUSTOM`           |             | `FALSE`                                      |
| `INSTAGRAM_ENCRYPTION_ROTATION_MESSAGES`                |             | `100`                                        |
| `INSTAGRAM_ENCRYPTION_ROTATION_MILLISECONDS`            |             | `604800000`                                  |
| `INSTAGRAM_ENCRYPTION_VERIFY_LEVELS_RECEIVE`            |             | `unverified`                                 |
| `INSTAGRAM_ENCRYPTION_VERIFY_LEVELS_SEND`               |             | `unverified`                                 |
| `INSTAGRAM_ENCRYPTION_VERIFY_LEVELS_SHARE`              |             | `cross-signed-tofu`                          |
| `INSTAGRAM_FEDERATE_ROOMS`                              |             | `TRUE`                                       |
| `INSTAGRAM_GET_PROXY_API_URL`                           |             | `null`                                       |
| `INSTAGRAM_HOMESERVER_ADDRESS`                          |             | `${HOMESERVER_ADDRESS}`                      |
| `INSTAGRAM_HOMESERVER_DOMAIN`                           |             | `${HOMESERVER_DOMAIN}`                       |
| `INSTAGRAM_HOMESERVER_ENABLE_ASYNC_UPLOADS`             |             | `${HOMESERVER_ENABLE_ASYNC_UPLOADS}`         |
| `INSTAGRAM_HOMESERVER_HTTP_RETRY_COUNT`                 |             | `${HOMESERVER_HTTP_RETRY_COUNT}`             |
| `INSTAGRAM_HOMESERVER_MESSAGE_SEND_CHECKPOINT_ENDPOINT` |             | `null`                                       |
| `INSTAGRAM_HOMESERVER_SOFTWARE`                         |             | `${HOMESERVER_SOFTWARE}`                     |
| `INSTAGRAM_HOMESERVER_STATUS_ENDPOINT`                  |             | `null`                                       |
| `INSTAGRAM_HOMESERVER_TLS_VERIFY`                       |             | `${HOMESERVER_TLS_VERIFY}`                   |
| `INSTAGRAM_LISTEN_IP`                                   |             | `0.0.0.0`                                    |
| `INSTAGRAM_LISTEN_PORT`                                 |             | `29330`                                      |
| `INSTAGRAM_LOG_FILE`                                    |             | `instagram.log`                              |
| `INSTAGRAM_LOG_LEVEL`                                   |             | `${LOG_LEVEL}`                               |
| `INSTAGRAM_LOG_PATH`                                    |             | `${LOG_PATH}`                                |
| `INSTAGRAM_LOG_TYPE`                                    |             | `${LOG_TYPE}`                                |
| `INSTAGRAM_MAX_STARTUP_THREAD_SYNC_COUNT`               |             | `20`                                         |
| `INSTAGRAM_METRICS_LISTEN_IP`                           |             | `127.0.0.1`                                  |
| `INSTAGRAM_METRICS_LISTEN_PORT`                         |             | `4400`                                       |
| `INSTAGRAM_PERIODIC_RECONNECT_ALWAYS`                   |             | `FALSE`                                      |
| `INSTAGRAM_PERIODIC_RECONNECT_INTERVAL`                 |             | `-1`                                         |
| `INSTAGRAM_PERIODIC_RECONNECT_RESYNC`                   |             | `TRUE`                                       |
| `INSTAGRAM_PERMISSIONS_ADMIN`                           |             | `@admin:example.com`                         |
| `INSTAGRAM_PERMISSIONS_RELAY`                           |             | `*`                                          |
| `INSTAGRAM_PERMISSIONS_USER`                            |             | `example.com`                                |
| `INSTAGRAM_PRIVATE_CHAT_PORTAL_META`                    |             | `FALSE`                                      |
| `INSTAGRAM_PROVISIONING_ENABLE`                         |             | `TRUE`                                       |
| `INSTAGRAM_PROVISIONING_PREFIX`                         |             | `/_matrix/provision`                         |
| `INSTAGRAM_PROVISIONING_SEGMENT_KEY`                    |             | `null`                                       |
| `INSTAGRAM_REGISTRATION_FILE`                           |             | `instagram-registration.yaml`                |
| `INSTAGRAM_REGISTRATION_PATH`                           |             | `${REGISTRATION_PATH}`                       |
| `INSTAGRAM_RESEND_BRIDGE_INFO`                          |             | `FALSE`                                      |
| `INSTAGRAM_SYNC_DIRECT_CHAT_LIST`                       |             | `FALSE`                                      |
| `INSTAGRAM_SYNC_WITH_CUSTOM_PUPPETS`                    |             | `FALSE`                                      |
| `INSTAGRAM_TEMPLATE_DISPLAYNAME`                        |             | `{displayname} (Instagram)`                  |
| `INSTAGRAM_TEMPLATE_GROUP_CHAT_NAME`                    |             | `{name}`                                     |
| `INSTAGRAM_TEMPLATE_PRIVATE_CHAT_NAME`                  |             | `{displayname}`                              |
| `INSTAGRAM_TEMPLATE_USERNAME`                           |             | `instagram_{userid}`                         |
| `INSTAGRAM_UNIMPORTANT_BRIDGE_NOTICES`                  |             | `TRUE`                                       |

#### Signal

Signal bridge provided by [Mautrix Signal Bridge](https://github.com/mautrix/signal)

| Variable                                             | Description | Default                                        |
| ---------------------------------------------------- | ----------- | ---------------------------------------------- |
| `SIGNAL_ALLOW_CONTACT_LIST_NAMES`                    |             | `TRUE`                                         |
| `SIGNAL_APPSERVICE_ID`                               |             | `signal`                                       |
| `SIGNAL_ATTACHMENT_PATH`                             |             | `${SIGNAL_DATA_PATH}/attachments`              |
| `SIGNAL_AUTHDATA_PATH`                               |             | `${SIGNAL_DATA_PATH}/authdata`                 |
| `SIGNAL_AUTOCREATE_CONTACT_PORTAL`                   |             | `FALSE`                                        |
| `SIGNAL_AUTOCREATE_GROUP_PORTAL`                     |             | `FALSE`                                        |
| `SIGNAL_AVATAR_PATH`                                 |             | `${SIGNAL_DATA_PATH}/avatars`                  |
| `SIGNAL_BOT_AVATAR`                                  |             | `mxc://maunium.net/NeXNQarUbrlYBiPCpprYsRqr`   |
| `SIGNAL_BOT_DISPLAYNAME`                             |             | `Signal bridge bot`                            |
| `SIGNAL_BOT_USERNAME`                                |             | `signalbot`                                    |
| `SIGNAL_BRIDGE_MATRIX_LEAVE`                         |             | `TRUE`                                         |
| `SIGNAL_COMMAND_PREFIX`                              |             | `!signal`                                      |
| `SIGNAL_CONFIG_FILE`                                 |             | `signal.yaml`                                  |
| `SIGNAL_CONFIG_PATH`                                 |             | `${CONFIG_PATH}`                               |
| `SIGNAL_CONFIGURE_BRIDGE`                            |             | `TRUE`                                         |
| `SIGNAL_DATA_PATH`                                   |             | `${DATA_PATH}/signal/`                         |
| `SIGNAL_DELETE_UNKNOWN_ACCOUNTS_ON_START`            |             | `FALSE`                                        |
| `SIGNAL_DOUBLE_PUPPET_ALLOW_DISCOVERY`               |             | `FALSE`                                        |
| `SIGNAL_ENABLE_DELIVERY_ERROR_REPORTS`               |             | `TRUE`                                         |
| `SIGNAL_ENABLE_DELIVERY_RECEIPTS`                    |             | `FALSE`                                        |
| `SIGNAL_ENABLE_DISAPPEARING_MESSAGES_IN_GROUPS`      |             | `TRUE`                                         |
| `SIGNAL_ENABLE_MESSAGE_STATUS_EVENTS`                |             | `FALSE`                                        |
| `SIGNAL_ENABLE_METRICS`                              |             | `FALSE`                                        |
| `SIGNAL_ENCRYPTION_ALLOW`                            |             | `FALSE`                                        |
| `SIGNAL_ENCRYPTION_ALLOW_KEY_SHARING`                |             | `FALSE`                                        |
| `SIGNAL_ENCRYPTION_APPSERVICE`                       |             | `FALSE`                                        |
| `SIGNAL_ENCRYPTION_DEFAULT`                          |             | `FALSE`                                        |
| `SIGNAL_ENCRYPTION_REQUIRE`                          |             | `FALSE`                                        |
| `SIGNAL_ENCRYPTION_ROTATION_ENABLE_CUSTOM`           |             | `FALSE`                                        |
| `SIGNAL_ENCRYPTION_ROTATION_MESSAGES`                |             | `100`                                          |
| `SIGNAL_ENCRYPTION_ROTATION_MILLISECONDS`            |             | `604800000`                                    |
| `SIGNAL_ENCRYPTION_VERIFY_LEVELS_RECEIVE`            |             | `unverified`                                   |
| `SIGNAL_ENCRYPTION_VERIFY_LEVELS_SEND`               |             | `unverified`                                   |
| `SIGNAL_ENCRYPTION_VERIFY_LEVELS_SHARE`              |             | `cross-signed-tofu`                            |
| `SIGNAL_HOMESERVER_ADDRESS`                          |             | `${HOMESERVER_ADDRESS}`                        |
| `SIGNAL_HOMESERVER_DOMAIN`                           |             | `${HOMESERVER_DOMAIN}`                         |
| `SIGNAL_HOMESERVER_ENABLE_ASYNC_UPLOADS`             |             | `${HOMESERVER_ENABLE_ASYNC_UPLOADS}`           |
| `SIGNAL_HOMESERVER_HTTP_RETRY_COUNT`                 |             | `${HOMESERVER_HTTP_RETRY_COUNT}`               |
| `SIGNAL_HOMESERVER_MESSAGE_SEND_CHECKPOINT_ENDPOINT` |             | `null`                                         |
| `SIGNAL_HOMESERVER_SOFTWARE`                         |             | `${HOMESERVER_SOFTWARE}`                       |
| `SIGNAL_HOMESERVER_STATUS_ENDPOINT`                  |             | `null`                                         |
| `SIGNAL_HOMESERVER_TLS_VERIFY`                       |             | `${HOMESERVER_TLS_VERIFY}`                     |
| `SIGNAL_LISTEN_IP`                                   |             | `0.0.0.0`                                      |
| `SIGNAL_LISTEN_PORT`                                 |             | `29328`                                        |
| `SIGNAL_LOG_FILE`                                    |             | `signal.log`                                   |
| `SIGNAL_LOG_LEVEL`                                   |             | `${LOG_LEVEL}`                                 |
| `SIGNAL_LOG_PATH`                                    |             | `${LOG_PATH}`                                  |
| `SIGNAL_LOG_TYPE`                                    |             | `${LOG_TYPE}`                                  |
| `SIGNAL_MANAGEMENT_ROOM_MULTIPLE_MESSAGES`           |             | `TRUE`                                         |
| `SIGNAL_MANAGEMENT_ROOM_TEXT_ADDITIONAL_HELP`        |             | ``                                             |
| `SIGNAL_MANAGEMENT_ROOM_TEXT_WELCOME`                |             | `Hello, I'm a Signal bridge bot.`              |
| `SIGNAL_MANAGEMENT_ROOM_TEXT_WELCOME_CONNECTED`      |             | `Hello, I'm a Signal bridge bot.`              |
| `SIGNAL_MANAGEMENT_ROOM_TEXT_WELCOME_UNCONNECTED`    |             | `Use \`help\` for help or \`link\` to log in.` |
| `SIGNAL_METRICS_LISTEN_IP`                           |             | `127.0.0.1`                                    |
| `SIGNAL_METRICS_LISTEN_PORT`                         |             | `7465`                                         |
| `SIGNAL_PERIODIC_RECONNECT_INTERVAL`                 |             | `0`                                            |
| `SIGNAL_PERMISSIONS_ADMIN`                           |             | `@admin:example.com`                           |
| `SIGNAL_PERMISSIONS_RELAY`                           |             | `*`                                            |
| `SIGNAL_PERMISSIONS_USER`                            |             | `example.com`                                  |
| `SIGNAL_PRIVATE_CHAT_PORTAL_META`                    |             | `FALSE`                                        |
| `SIGNAL_PROVISIONING_ENABLE`                         |             | `TRUE`                                         |
| `SIGNAL_PROVISIONING_PREFIX`                         |             | `/_matrix/provision`                           |
| `SIGNAL_PROVISIONING_SEGMENT_KEY`                    |             | `null`                                         |
| `SIGNAL_PUBLIC_PORTALS`                              |             | `FALSE`                                        |
| `SIGNAL_REGISTRATION_ENABLED`                        |             | `TRUE`                                         |
| `SIGNAL_REGISTRATION_FILE`                           |             | `signal-registration.yaml`                     |
| `SIGNAL_REGISTRATION_PATH`                           |             | `${REGISTRATION_PATH}`                         |
| `SIGNAL_REMOVE_FILE_AFTER_HANDLING`                  |             | `TRUE`                                         |
| `SIGNAL_RESEND_BRIDGE_INFO`                          |             | `FALSE`                                        |
| `SIGNAL_SYNC_DIRECT_CHAT_LIST`                       |             | `FALSE`                                        |
| `SIGNAL_SYNC_WITH_CUSTOM_PUPPETS`                    |             | `FALSE`                                        |
| `SIGNAL_TEMPLATE_DISPLAYNAME`                        |             | `{displayname} (Signal)`                       |
| `SIGNAL_TEMPLATE_DISPLAYNAME_PREFERENCE`             |             | `full_name,phone`                              |
| `SIGNAL_TEMPLATE_USERNAME`                           |             | `signal_{userid}`                              |

#### Slack

Slack bridge provided by [Mautrix Slack Bridge](https://github.com/mautrix/slack)

| Variable                                            | Description | Default                                      |
| --------------------------------------------------- | ----------- | -------------------------------------------- |
| `SLACK_APPSERVICE_ID`                               |             | `slack`                                      |
| `SLACK_BOT_AVATAR`                                  |             | `mxc://maunium.net/pVtzLmChZejGxLqmXtQjFxem` |
| `SLACK_BOT_DISPLAYNAME`                             |             | `Slack bridge bot`                           |
| `SLACK_BOT_USERNAME`                                |             | `slackbot`                                   |
| `SLACK_CONFIG_FILE`                                 |             | `slack.yaml`                                 |
| `SLACK_CONFIG_PATH`                                 |             | `${CONFIG_PATH}`                             |
| `SLACK_CONFIGURE_BRIDGE`                            |             | `TRUE`                                       |
| `SLACK_DATA_PATH`                                   |             | `${DATA_PATH}/slack/`                        |
| `SLACK_ENABLE_METRICS`                              |             | `FALSE`                                      |
| `SLACK_ENCRYPTION_ALLOW`                            |             | `FALSE`                                      |
| `SLACK_ENCRYPTION_ALLOW_KEY_SHARING`                |             | `FALSE`                                      |
| `SLACK_ENCRYPTION_APPSERVICE`                       |             | `FALSE`                                      |
| `SLACK_ENCRYPTION_DEFAULT`                          |             | `FALSE`                                      |
| `SLACK_ENCRYPTION_REQUIRE`                          |             | `FALSE`                                      |
| `SLACK_ENCRYPTION_ROTATION_ENABLE_CUSTOM`           |             | `FALSE`                                      |
| `SLACK_ENCRYPTION_ROTATION_MESSAGES`                |             | `100`                                        |
| `SLACK_ENCRYPTION_ROTATION_MILLISECONDS`            |             | `604800000`                                  |
| `SLACK_ENCRYPTION_VERIFY_LEVELS_RECEIVE`            |             | `unverified`                                 |
| `SLACK_ENCRYPTION_VERIFY_LEVELS_SEND`               |             | `unverified`                                 |
| `SLACK_ENCRYPTION_VERIFY_LEVELS_SHARE`              |             | `cross-signed-tofu`                          |
| `SLACK_HOMESERVER_ADDRESS`                          |             | `${HOMESERVER_ADDRESS}`                      |
| `SLACK_HOMESERVER_DOMAIN`                           |             | `${HOMESERVER_DOMAIN}`                       |
| `SLACK_HOMESERVER_ENABLE_ASYNC_UPLOADS`             |             | `${HOMESERVER_ENABLE_ASYNC_UPLOADS}`         |
| `SLACK_HOMESERVER_HTTP_RETRY_COUNT`                 |             | `${HOMESERVER_HTTP_RETRY_COUNT}`             |
| `SLACK_HOMESERVER_MESSAGE_SEND_CHECKPOINT_ENDPOINT` |             | `null`                                       |
| `SLACK_HOMESERVER_SOFTWARE`                         |             | `${HOMESERVER_SOFTWARE}`                     |
| `SLACK_HOMESERVER_STATUS_ENDPOINT`                  |             | `null`                                       |
| `SLACK_HOMESERVER_TLS_VERIFY`                       |             | `${HOMESERVER_TLS_VERIFY}`                   |
| `SLACK_LISTEN_IP`                                   |             | `0.0.0.0`                                    |
| `SLACK_LISTEN_PORT`                                 |             | `29335`                                      |
| `SLACK_LOG_FILE`                                    |             | `slack.log`                                  |
| `SLACK_LOG_LEVEL`                                   |             | `${LOG_LEVEL}`                               |
| `SLACK_LOG_PATH`                                    |             | `${LOG_PATH}`                                |
| `SLACK_LOG_TYPE`                                    |             | `${LOG_TYPE}`                                |
| `SLACK_METRICS_LISTEN_IP`                           |             | `127.0.0.1`                                  |
| `SLACK_METRICS_LISTEN_PORT`                         |             | `7522`                                       |
| `SLACK_PERMISSIONS_ADMIN`                           |             | `@admin:example.com`                         |
| `SLACK_PERMISSIONS_RELAY`                           |             | `*`                                          |
| `SLACK_PERMISSIONS_USER`                            |             | `example.com`                                |
| `SLACK_REGISTRATION_FILE`                           |             | `slack-registration.yaml`                    |
| `SLACK_REGISTRATION_PATH`                           |             | `${REGISTRATION_PATH}`                       |
| `SLACK_TEMPLATE_DISPLAYNAME`                        |             | `{{.RealName}} (S)`                          |
| `SLACK_TEMPLATE_USERNAME`                           |             | `slack_{{.}}`                                |
| `SLACK_COMMAND_PREFIX`                              |             | `!slack`                                     |

#### Telegram

Telegram chat bridge provided by [Mautrix Telegram Bridge](https://github.com/mautrix/telegram)

| Variable                                                 | Description | Default                                                                                                |
| -------------------------------------------------------- | ----------- | ------------------------------------------------------------------------------------------------------ |
| `TELEGRAM_ALLOW_AVATAR_REMOVE`                           |             | `false`                                                                                                |
| `TELEGRAM_ALLOW_CONTACT_INFO`                            |             | `false`                                                                                                |
| `TELEGRAM_ALLOW_MATRIX_LOGIN`                            |             | `true`                                                                                                 |
| `TELEGRAM_ALWAYS_CUSTOM_EMOJI_REACTION`                  |             | `false`                                                                                                |
| `TELEGRAM_ALWAYS_READ_JOINED_TELEGRAM_NOTICE`            |             | `true`                                                                                                 |
| `TELEGRAM_ANIMATED_EMOJI_ARGS_HEIGHT`                    |             | `64`                                                                                                   |
| `TELEGRAM_ANIMATED_EMOJI_ARGS_WIDTH`                     |             | `64`                                                                                                   |
| `TELEGRAM_ANIMATED_EMOJI_FPS`                            |             | `25`                                                                                                   |
| `TELEGRAM_ANIMATED_EMOJI_TARGET`                         |             | `webp`                                                                                                 |
| `TELEGRAM_ANIMATED_STICKER_ARGS_HEIGHT`                  |             | `256`                                                                                                  |
| `TELEGRAM_ANIMATED_STICKER_ARGS_WIDTH`                   |             | `256`                                                                                                  |
| `TELEGRAM_ANIMATED_STICKER_CONVERT_FROM_WEBM`            |             | `false`                                                                                                |
| `TELEGRAM_ANIMATED_STICKER_TARGET`                       |             | `gif`                                                                                                  |
| `TELEGRAM_API_HASH`                                      |             | `tjyd5yge35lbodk1xwzw2jstp90k55qz`                                                                     |
| `TELEGRAM_API_ID`                                        |             | `12345`                                                                                                |
| `TELEGRAM_APPSERVICE_ID`                                 |             | `telegram`                                                                                             |
| `TELEGRAM_ARCHIVE_TAG`                                   |             | `null`                                                                                                 |
| `TELEGRAM_AUTHLESS_PORTALS`                              |             | `true`                                                                                                 |
| `TELEGRAM_BACKFILL_DOUBLE_PUPPET`                        |             | `false`                                                                                                |
| `TELEGRAM_BACKFILL_ENABLE`                               |             | `true`                                                                                                 |
| `TELEGRAM_BACKFILL_ENABLE_MSC2716`                       |             | `false`                                                                                                |
| `TELEGRAM_BACKFILL_FORWARD_INITIAL_LIMIT`                |             | `10`                                                                                                   |
| `TELEGRAM_BACKFILL_FORWARD_SYNC_LIMIT`                   |             | `100`                                                                                                  |
| `TELEGRAM_BACKFILL_INCREMENTAL_MAX_BATCHES_CHANNEL`      |             | `-1`                                                                                                   |
| `TELEGRAM_BACKFILL_INCREMENTAL_MAX_BATCHES_NORMAL_GROUP` |             | `-1`                                                                                                   |
| `TELEGRAM_BACKFILL_INCREMENTAL_MAX_BATCHES_SUPERGROUP`   |             | `10`                                                                                                   |
| `TELEGRAM_BACKFILL_INCREMENTAL_MAX_BATCHES_USER`         |             | `-1`                                                                                                   |
| `TELEGRAM_BACKFILL_INCREMENTAL_MESSAGES_PER_BATCH`       |             | `100`                                                                                                  |
| `TELEGRAM_BACKFILL_INCREMENTAL_POST_BATCH_DELAY`         |             | `20`                                                                                                   |
| `TELEGRAM_BACKFILL_INITIAL_POWER_LEVEL_OVERRIDES_GROUP`  |             | `{}`                                                                                                   |
| `TELEGRAM_BACKFILL_INITIAL_POWER_LEVEL_OVERRIDES_USER`   |             | `{}`                                                                                                   |
| `TELEGRAM_BACKFILL_NORMAL_GROUPS`                        |             | `false`                                                                                                |
| `TELEGRAM_BACKFILL_UNREAD_HOURS_THRESHOLD`               |             | `720`                                                                                                  |
| `TELEGRAM_BOT_AVATAR`                                    |             | `mxc://maunium.net/NeXNQarUbrlYBiPCpprYsRqr`                                                           |
| `TELEGRAM_BOT_DISPLAYNAME`                               |             | `Telegram bridge bot`                                                                                  |
| `TELEGRAM_BOT_MESSAGES_AS_NOTICES`                       |             | `true`                                                                                                 |
| `TELEGRAM_BOT_TOKEN`                                     |             | `disabled`                                                                                             |
| `TELEGRAM_BOT_USERNAME`                                  |             | `telegrambot`                                                                                          |
| `TELEGRAM_BRIDGE_MATRIX_LEAVE`                           |             | `true`                                                                                                 |
| `TELEGRAM_BRIDGE_NOTICES_DEFAULT`                        |             | `false`                                                                                                |
| `TELEGRAM_BRIDGE_NOTICES_EXCEPTIONS`                     |             | `[]`                                                                                                   |
| `TELEGRAM_CAPTION_IN_MESSAGE`                            |             | `false`                                                                                                |
| `TELEGRAM_CATCH_UP`                                      |             | `true`                                                                                                 |
| `TELEGRAM_COMMAND_PREFIX`                                |             | `!tg`                                                                                                  |
| `TELEGRAM_CONFIG_FILE`                                   |             | `telegram.yaml`                                                                                        |
| `TELEGRAM_CONFIG_PATH`                                   |             | `${CONFIG_PATH}`                                                                                       |
| `TELEGRAM_CONFIGURE_BRIDGE`                              |             | `TRUE`                                                                                                 |
| `TELEGRAM_CONNECTION_FLOOD_SLEEP_THRESHOLD`              |             | `60`                                                                                                   |
| `TELEGRAM_CONNECTION_REQUEST_RETRIES`                    |             | `5`                                                                                                    |
| `TELEGRAM_CONNECTION_RETRIES`                            |             | `5`                                                                                                    |
| `TELEGRAM_CONNECTION_RETRY_DELAY`                        |             | `1`                                                                                                    |
| `TELEGRAM_CONNECTION_TIMEOUT`                            |             | `120`                                                                                                  |
| `TELEGRAM_CREATE_GROUP_ON_INVITE`                        |             | `true`                                                                                                 |
| `TELEGRAM_DATA_PATH`                                     |             | `${DATA_PATH}/telegram/`                                                                               |
| `TELEGRAM_DEVICE_APP_VERSION`                            |             | `auto`                                                                                                 |
| `TELEGRAM_DEVICE_LANG_CODE`                              |             | `en`                                                                                                   |
| `TELEGRAM_DEVICE_MODEL`                                  |             | `mautrix-telegram`                                                                                     |
| `TELEGRAM_DEVICE_SYSTEM_LANG_CODE`                       |             | `en`                                                                                                   |
| `TELEGRAM_DEVICE_SYSTEM_VERSION`                         |             | `auto`                                                                                                 |
| `TELEGRAM_DISABLE_BRIDGE_NOTICES`                        |             | `FALSE`                                                                                                |
| `TELEGRAM_DOUBLE_PUPPET_ALLOW_DISCOVERY`                 |             | `false`                                                                                                |
| `TELEGRAM_EMOTE_FORMAT`                                  |             | `* \$mention \$formatted_body`                                                                         |
| `TELEGRAM_ENABLE_DELIVERY_ERROR_REPORTS`                 |             | `TRUE`                                                                                                 |
| `TELEGRAM_ENABLE_DELIVERY_RECEIPTS`                      |             | `FALSE`                                                                                                |
| `TELEGRAM_ENABLE_MESSAGE_STATUS_EVENTS`                  |             | `FALSE`                                                                                                |
| `TELEGRAM_ENABLE_METRICS`                                |             | `FALSE`                                                                                                |
| `TELEGRAM_ENCRYPTION_ALLOW`                              |             | `FALSE`                                                                                                |
| `TELEGRAM_ENCRYPTION_ALLOW_KEY_SHARING`                  |             | `FALSE`                                                                                                |
| `TELEGRAM_ENCRYPTION_APPSERVICE`                         |             | `FALSE`                                                                                                |
| `TELEGRAM_ENCRYPTION_DEFAULT`                            |             | `FALSE`                                                                                                |
| `TELEGRAM_ENCRYPTION_REQUIRE`                            |             | `FALSE`                                                                                                |
| `TELEGRAM_ENCRYPTION_ROTATION_ENABLE_CUSTOM`             |             | `FALSE`                                                                                                |
| `TELEGRAM_ENCRYPTION_ROTATION_MESSAGES`                  |             | `100`                                                                                                  |
| `TELEGRAM_ENCRYPTION_ROTATION_MILLISECONDS`              |             | `604800000`                                                                                            |
| `TELEGRAM_ENCRYPTION_VERIFY_LEVELS_RECEIVE`              |             | `unverified`                                                                                           |
| `TELEGRAM_ENCRYPTION_VERIFY_LEVELS_SEND`                 |             | `unverified`                                                                                           |
| `TELEGRAM_ENCRYPTION_VERIFY_LEVELS_SHARE`                |             | `cross-signed-tofu`                                                                                    |
| `TELEGRAM_EXIT_ON_UPDATE_ERROR`                          |             | `false`                                                                                                |
| `TELEGRAM_FEDERATE_ROOMS`                                |             | `TRUE`                                                                                                 |
| `TELEGRAM_FEDERATE_ROOMS`                                |             | `true`                                                                                                 |
| `TELEGRAM_FILTER_LIST`                                   |             | `[]`                                                                                                   |
| `TELEGRAM_FILTER_MODE`                                   |             | `blacklist`                                                                                            |
| `TELEGRAM_GROUP_CHAT_INVITE`                             |             | `[]`                                                                                                   |
| `TELEGRAM_HOMESERVER_ADDRESS`                            |             | `${HOMESERVER_ADDRESS}`                                                                                |
| `TELEGRAM_HOMESERVER_DOMAIN`                             |             | `${HOMESERVER_DOMAIN}`                                                                                 |
| `TELEGRAM_HOMESERVER_ENABLE_ASYNC_UPLOADS`               |             | `${HOMESERVER_ENABLE_ASYNC_UPLOADS}`                                                                   |
| `TELEGRAM_HOMESERVER_HTTP_RETRY_COUNT`                   |             | `${HOMESERVER_HTTP_RETRY_COUNT}`                                                                       |
| `TELEGRAM_HOMESERVER_MESSAGE_SEND_CHECKPOINT_ENDPOINT`   |             | `null`                                                                                                 |
| `TELEGRAM_HOMESERVER_SOFTWARE`                           |             | `${HOMESERVER_SOFTWARE}`                                                                               |
| `TELEGRAM_HOMESERVER_STATUS_ENDPOINT`                    |             | `null`                                                                                                 |
| `TELEGRAM_HOMESERVER_TLS_VERIFY`                         |             | `${HOMESERVER_TLS_VERIFY}`                                                                             |
| `TELEGRAM_IGNORE_OWN_INCOMING_EVENTS`                    |             | `TRUE`                                                                                                 |
| `TELEGRAM_IGNORE_UNBRIDGED_GROUP_CHAT`                   |             | `true`                                                                                                 |
| `TELEGRAM_IMAGE_AS_FILE_PIXELS`                          |             | `16777216`                                                                                             |
| `TELEGRAM_IMAGE_AS_FILE_SIZE`                            |             | `10`                                                                                                   |
| `TELEGRAM_INVITE_LINK_RESOLVE`                           |             | `false`                                                                                                |
| `TELEGRAM_KICK_ON_LOGOUT`                                |             | `true`                                                                                                 |
| `TELEGRAM_LINK_PREVIEW`                                  |             | `true`                                                                                                 |
| `TELEGRAM_LISTEN_IP`                                     |             | `0.0.0.0`                                                                                              |
| `TELEGRAM_LISTEN_PORT`                                   |             | `28476`                                                                                                |
| `TELEGRAM_LOG_FILE`                                      |             | `telegram.log`                                                                                         |
| `TELEGRAM_LOG_LEVEL`                                     |             | `${LOG_LEVEL}`                                                                                         |
| `TELEGRAM_LOG_PATH`                                      |             | `${LOG_PATH}`                                                                                          |
| `TELEGRAM_LOG_TYPE`                                      |             | `${LOG_TYPE}`                                                                                          |
| `TELEGRAM_MANAGEMENT_ROOM_MULTIPLE_MESSAGES`             |             | `false`                                                                                                |
| `TELEGRAM_MANAGEMENT_ROOM_TEXT_ADDITIONAL_HELP`          |             | ``                                                                                                     |
| `TELEGRAM_MANAGEMENT_ROOM_TEXT_CONNECTED`                |             | `Use \`help\` for help.`                                                                               |
| `TELEGRAM_MANAGEMENT_ROOM_TEXT_UNCONNECTED`              |             | `Use \`help\` for help or \`login\` to log in.`                                                        |
| `TELEGRAM_MANAGEMENT_ROOM_TEXT_WELCOME`                  |             | `Hello, I'm a Telegram bridge bot.`                                                                    |
| `TELEGRAM_MAX_INITIAL_MEMBER_SYNC                        |             | `100`                                                                                                  |
| `TELEGRAM_MAX_MEMBER_COUNT`                              |          | `1` |
| `TELEGRAM_MAX_TELEGRAM_DELETE`                           |             | `10`                                                                                                   |
| `TELEGRAM_MESSAGE_FORMATS_M_AUDIO`                       |             | `\$distinguisher <b>\$sender_displayname</b> sent an audio file: \$message`                            |
| `TELEGRAM_MESSAGE_FORMATS_M_EMOTE`                       |             | `* \$distinguisher <b>\$sender_displayname</b>: \$message`                                             |
| `TELEGRAM_MESSAGE_FORMATS_M_FILE`                        |             | `\$distinguisher <b>\$sender_displayname</b> sent a file: \$message`                                   |
| `TELEGRAM_MESSAGE_FORMATS_M_IMAGE`                       |             | `\$distinguisher <b>\$sender_displayname</b> sent an image: \$message`                                 |
| `TELEGRAM_MESSAGE_FORMATS_M_LOCATION`                    |             | `\$distinguisher <b>\$sender_displayname</b> sent a location: \$message`                               |
| `TELEGRAM_MESSAGE_FORMATS_M_NOTICE`                      |             | `\$distinguisher <b>\$sender_displayname</b>: \$message`                                               |
| `TELEGRAM_MESSAGE_FORMATS_M_TEXT`                        |             | `\$distinguisher <b>\$sender_displayname</b>: \$message`                                               |
| `TELEGRAM_MESSAGE_FORMATS_M_VIDEO`                       |             | `\$distinguisher <b>\$sender_displayname</b> sent a video: \$message`                                  |
| `TELEGRAM_METRICS_LISTEN_IP`                             |             | `127.0.0.1`                                                                                            |
| `TELEGRAM_METRICS_LISTEN_PORT`                           |             | `8476`                                                                                                 |
| `TELEGRAM_MUTE_BRIDGING`                                 |             | `false`                                                                                                |
| `TELEGRAM_PARALLEL_FILE_TRANSFER`                        |             | `false`                                                                                                |
| `TELEGRAM_PERMISSIONS_ADMIN`                             |             | `@admin:example.com`                                                                                   |
| `TELEGRAM_PERMISSIONS_RELAY`                             |             | `*`                                                                                                    |
| `TELEGRAM_PERMISSIONS_USER`                              |             | `example.com`                                                                                          |
| `TELEGRAM_PINNED_TAG`                                    |             | `null`                                                                                                 |
| `TELEGRAM_PRIVATE_CHAT_PORTAL_META`                      |             | `false`                                                                                                |
| `TELEGRAM_PROVISIONING_ENABLE`                           |             | `TRUE`                                                                                                 |
| `TELEGRAM_PROVISIONING_PREFIX`                           |             | `/_matrix/provision`                                                                                   |
| `TELEGRAM_PROVISIONING_SEGMENT_KEY`                      |             | `null`                                                                                                 |
| `TELEGRAM_PROXY_ADDRESS`                                 |             | `127.0.0.1`                                                                                            |
| `TELEGRAM_PROXY_PASS`                                    |             | ``                                                                                                     |
| `TELEGRAM_PROXY_PORT`                                    |             | `1080`                                                                                                 |
| `TELEGRAM_PROXY_RDNS`                                    |             | `true`                                                                                                 |
| `TELEGRAM_PROXY_TYPE`                                    |             | `disabled`                                                                                             |
| `TELEGRAM_PROXY_USER`                                    |             | ``                                                                                                     |
| `TELEGRAM_PUBLIC_PORTALS`                                |             | `false`                                                                                                |
| `TELEGRAM_REGISTRATION_FILE`                             |             | `telegram-registration.yaml`                                                                           |
| `TELEGRAM_REGISTRATION_PATH`                             |             | `${REGISTRATION_PATH}`                                                                                 |
| `TELEGRAM_RELAYBOT_PRIVATECHAT_INVITE`                   |             | `[]`                                                                                                   |
| `TELEGRAM_RELAYBOT_PRIVATECHAT_MESSAGE`                  |             | `This is a Matrix bridge relaybot and does not support direct chats`                                   |
| `TELEGRAM_RELAYBOT_PRIVATECHAT_STATE_CHANGES`            |             | `true`                                                                                                 |
| `TELEGRAM_RELAY_USER_DISTINGUISHERS`                     |             | `[\"🟦\", \"🟣\", \"🟩\", \"⭕️\", \"🔶\", \"⬛️\", \"🔵\", \"🟢\"]`                                             |
| `TELEGRAM_RESEND_BRIDGE_INFO`                            |             | `FALSE`                                                                                                |
| `TELEGRAM_RESEND_BRIDGE_INFO`                            |             | `false`                                                                                                |
| `TELEGRAM_SEQUENTIAL_UPDATES`                            |             | `true`                                                                                                 |
| `TELEGRAM_SERVER_DC`                                     |             | `2`                                                                                                    |
| `TELEGRAM_SERVER_ENABLED`                                |             | `false`                                                                                                |
| `TELEGRAM_SERVER_IP`                                     |             | `149.154.167.40`                                                                                       |
| `TELEGRAM_SERVER_PORT`                                   |             | `80`                                                                                                   |
| `TELEGRAM_SKIP_DELETED_MEMBERS`                          |             | `true`                                                                                                 |
| `TELEGRAM_STARTUP_SYNC`                                  |             | `false`                                                                                                |
| `TELEGRAM_STATE_EVENT_FORMATS_JOIN`                      |             | `\$distinguisher <b>\$displayname</b> joined the room.`                                                |
| `TELEGRAM_STATE_EVENT_FORMATS_LEAVE`                     |             | `\$distinguisher <b>\$displayname</b> left the room.`                                                  |
| `TELEGRAM_STATE_EVENT_FORMATS_NAME_CHANGE`               |             | `\$distinguisher <b>\$prev_displayname</b> changed their name to \$distinguisher <b>\$displayname</b>` |
| `TELEGRAM_SYNC_CHANNEL_MEMBERS`                          |             | `false`                                                                                                |
| `TELEGRAM_SYNC_CREATE_LIMIT`                             |             | `15`                                                                                                   |
| `TELEGRAM_SYNC_DEFERRED_CREATE_ALL`                      |             | `false`                                                                                                |
| `TELEGRAM_SYNC_DIRECT_CHATS`                             |             | `false`                                                                                                |
| `TELEGRAM_SYNC_DIRECT_CHAT_LIST`                         |             | `false`                                                                                                |
| `TELEGRAM_SYNC_MATRIX_STATE`                             |             | `true`                                                                                                 |
| `TELEGRAM_SYNC_UPDATE_LIMIT`                             |             | `0`                                                                                                    |
| `TELEGRAM_SYNC_WITH_CUSTOM_PUPPETS`                      |             | `false`                                                                                                |
| `TELEGRAM_TAG_ONLY_ON_CREATE`                            |             | `true`                                                                                                 |
| `TELEGRAM_TEMPLATE_ALIAS`                                |             | `telegram_{groupname}`                                                                                 |
| `TELEGRAM_TEMPLATE_DISPLAYNAME`                          |             | `{displayname} (Telegram)`                                                                             |
| `TELEGRAM_TEMPLATE_DISPLAYNAME_MAX_LENGTH`               |             | `100`                                                                                                  |
| `TELEGRAM_TEMPLATE_DISPLAYNAME_PREFERENCE`               |             | `full name,username,phone number`                                                                      |
| `TELEGRAM_TEMPLATE_USERNAME`                             |             | `telegram_{userid}`                                                                                    |
| `TELEGRAM_UNIMPORTANT_BRIDGE_NOTICES`                    |             | `TRUE`                                                                                                 |
| `TELEGRAM_WHITELIST_GROUP_ADMINS`                        |             | `true`                                                                                                 |

#### Twitter

Twitter chat bridge provided by [Mautrix Twitter Bridge](https://github.com/mautrix/twitter)

| Variable                                    | Description | Default                                      |
| ------------------------------------------- | ----------- | -------------------------------------------- |
| `TWITTER_LISTEN_PORT`                       |             | `29327`                                      |
| `TWITTER_APPSERVER_ADDRESS`                 |             | `http://localhost:${TWITTER_LISTEN_PORT}`    |
| `TWITTER_APPSERVICE_ID`                     |             | `twitter`                                    |
| `TWITTER_BOT_AVATAR`                        |             | `mxc://maunium.net/HVHcnusJkQcpVcsVGZRELLCn` |
| `TWITTER_BOT_DISPLAYNAME`                   |             | `Twitter bridge bot`                         |
| `TWITTER_BOT_USERNAME`                      |             | `twitterbot`                                 |
| `TWITTER_COMMAND_PREFIX`                    |             | `!tw`                                        |
| `TWITTER_CONFIG_FILE`                       |             | `twitter.yaml`                               |
| `TWITTER_CONFIG_PATH`                       |             | `${CONFIG_PATH}`                             |
| `TWITTER_CONFIGURE_BRIDGE`                  |             | `TRUE`                                       |
| `TWITTER_DATA_PATH`                         |             | `${DATA_PATH}/facebook`                      |
| `TWITTER_DB_MAX_SIZE`                       |             | `10`                                         |
| `TWITTER_DB_MIN_SIZE`                       |             | `1`                                          |
| `TWITTER_DB_PORT`                           |             | `5432`                                       |
| `TWITTER_DB_SQLITE_FILE`                    |             | `facebook.db`                                |
| `TWITTER_DB_SQLITE_PATH`                    |             | `${DB_SQLITE_PATH}`                          |
| `TWITTER_DB_TYPE`                           |             | `SQLITE`                                     |
| `TWITTER_DISABLE_BRIDGE_NOTICES`            |             | `FALSE`                                      |
| `TWITTER_DISPLAYNAME_MAX_LENGTH`            |             | `100`                                        |
| `TWITTER_DOUBLE_PUPPET_ALLOW_DISCOVERY`     |             | `FALSE`                                      |
| `TWITTER_ENABLE_BRIDGE_NOTICES`             |             | `TRUE`                                       |
| `TWITTER_ENABLE_DELIVERY_ERROR_REPORTS`     |             | `TRUE`                                       |
| `TWITTER_ENABLE_DELIVERY_RECEIPTS`          |             | `FALSE`                                      |
| `TWITTER_ENABLE_MESSAGE_STATUS_EVENTS`      |             | `FALSE`                                      |
| `TWITTER_ENABLE_METRICS`                    |             | `FALSE`                                      |
| `TWITTER_ENCRYPTION_ALLOW`                  |             | `FALSE`                                      |
| `TWITTER_ENCRYPTION_ALLOW_KEY_SHARING`      |             | `FALSE`                                      |
| `TWITTER_ENCRYPTION_APPSERVICE`             |             | `FALSE`                                      |
| `TWITTER_ENCRYPTION_DEFAULT`                |             | `FALSE`                                      |
| `TWITTER_ENCRYPTION_REQUIRE`                |             | `FALSE`                                      |
| `TWITTER_ENCRYPTION_ROTATION_ENABLE_CUSTOM` |             | `FALSE`                                      |
| `TWITTER_ENCRYPTION_ROTATION_MESSAGES`      |             | `100`                                        |
| `TWITTER_ENCRYPTION_ROTATION_MILLISECONDS`  |             | `604800000`                                  |
| `TWITTER_ENCRYPTION_VERIFY_LEVELS_RECEIVE`  |             | `unverified`                                 |
| `TWITTER_ENCRYPTION_VERIFY_LEVELS_SEND`     |             | `unverified`                                 |
| `TWITTER_ENCRYPTION_VERIFY_LEVELS_SHARE`    |             | `cross-signed-tofu`                          |
| `TWITTER_ERROR_SLEEP`                       |             | `5`                                          |
| `TWITTER_FEDERATE_ROOMS`                    |             | `TRUE`                                       |
| `TWITTER_INITIAL_CONVERSATION_SYNC`         |             | `10`                                         |
| `TWITTER_LISTEN_IP`                         |             | `0.0.0.0`                                    |
| `TWITTER_LISTEN_PORT`                       |             | `29327`                                      |
| `TWITTER_LOG_FILE`                          |             | `twitter.log`                                |
| `TWITTER_LOG_LEVEL`                         |             | `${LOG_LEVEL}`                               |
| `TWITTER_LOG_PATH`                          |             | `${LOG_PATH}`                                |
| `TWITTER_LOG_TYPE`                          |             | `${LOG_TYPE}`                                |
| `TWITTER_MAX_POLL_ERRORS`                   |             | `12`                                         |
| `TWITTER_METRICS_LISTEN_IP`                 |             | `127.0.0.1`                                  |
| `TWITTER_METRICS_LISTEN_PORT`               |             | `8989`                                       |
| `TWITTER_PRIVATE_CHAT_PORTAL_META`          |             | `FALSE`                                      |
| `TWITTER_PROVISIONING_ENABLE`               |             | `TRUE`                                       |
| `TWITTER_PROVISIONING_PREFIX`               |             | `/_matrix/provision`                         |
| `TWITTER_PROVISIONING_SEGMENT_KEY`          |             | `null`                                       |
| `TWITTER_REGISTRATION_FILE`                 |             | `twitter-registration.yaml`                  |
| `TWITTER_REGISTRATION_PATH`                 |             | `${REGISTRATION_PATH}`                       |
| `TWITTER_RESEND_BRIDGE_INFO`                |             | `FALSE`                                      |
| `TWITTER_SYNC_DIRECT_CHAT_LIST`             |             | `FALSE`                                      |
| `TWITTER_SYNC_WITH_CUSTOM_PUPPETS`          |             | `FALSE`                                      |
| `TWITTER_TEMPLATE_DISPLAYNAME`              |             | `{displayname} (Twitter)`                    |
| `TWITTER_TEMPORARY_DISCONNECT_NOTICES`      |             | `FALSE`                                      |
| `TWITTER_UNIMPORTANT_BRIDGE_NOTICES`        |             | `TRUE`                                       |

#### Whatsapp

Whatsapp bridge provided by [Mautrix Whatsapp Bridge](https://github.com/mautrix/whatsapp)


| Variable | Description | Default |
| -------- | ----------- | ------- || `WHATSAPP_APPSERVICE_ID` | | `whatsapp` |
| `WHATSAPP_BOT_AVATAR` | | `mxc://maunium.net/NeXNQarUbrlYBiPCpprYsRqr` |
| `WHATSAPP_BOT_DISPLAYNAME` | | `Whatsapp bridge bot` |
| `WHATSAPP_BOT_USERNAME` | | `whatsappbot` |
| `WHATSAPP_BROWSER_NAME` | | `unknown` |
| `WHATSAPP_COMMAND_PREFIX` | | `!wa` |
| `WHATSAPP_CONFIG_FILE` | | `whatsapp.yaml` |
| `WHATSAPP_CONFIG_PATH` | | `${CONFIG_PATH}` |
| `WHATSAPP_CONFIGURE_BRIDGE` | | `TRUE` |
| `WHATSAPP_DATA_PATH` | | `${DATA_PATH}/whatsapp/` |
| `WHATSAPP_DB_CONNECTIONS_MAX_IDLE` | | `2` |
| `WHATSAPP_DB_CONNECTIONS_MAX_IDLE_LIFETIME` | | `null` |
| `WHATSAPP_DB_CONNECTIONS_MAX_LIFETIME` | | `null` |
| `WHATSAPP_DB_CONNECTIONS_MAX_OPEN` | | `20` |
| `WHATSAPP_DB_ENABLE_TLS` | | `FALSE` |
| `WHATSAPP_DB_PORT` | | `5432` |
| `WHATSAPP_DB_SQLITE_FILE` | | `whatsapp.db` |
| `WHATSAPP_DB_SQLITE_PATH` | | `${DB_SQLITE_PATH}` |
| `WHATSAPP_DB_TYPE` | | `SQLITE` |
| `WHATSAPP_ENABLE_ASYNC_TRANSACTIONS` | | `FALSE` |
| `WHATSAPP_ENABLE_CALL_START_NOTICES` | | `TRUE` |
| `WHATSAPP_ENABLE_DELIVERY_RECEIPTS` | | `FALSE` |
| `WHATSAPP_ENABLE_EPHEMERAL_EVENTS` | | `TRUE` |
| `WHATSAPP_ENABLE_IDENTITY_CHANGE_NOTICES` | | `FALSE` |
| `WHATSAPP_ENABLE_MANHOLE` | | `FALSE` |
| `WHATSAPP_ENABLE_MESSAGE_ERROR_NOTICES` | | `FALSE` |
| `WHATSAPP_ENABLE_MESSAGE_STATUS_EVENTS` | | `FALSE` |
| `WHATSAPP_ENABLE_METRICS` | | `FALSE` |
| `WHATSAPP_ENCRYPTION_ALLOW` | | `FALSE` |
| `WHATSAPP_ENCRYPTION_ALLOW_KEY_SHARING` | | `FALSE` |
| `WHATSAPP_ENCRYPTION_APPSERVICE` | | `FALSE` |
| `WHATSAPP_ENCRYPTION_DEFAULT` | | `FALSE` |
| `WHATSAPP_ENCRYPTION_REQUIRE` | | `FALSE` |
| `WHATSAPP_ENCRYPTION_ROTATION_ENABLE_CUSTOM` | | `FALSE` |
| `WHATSAPP_ENCRYPTION_ROTATION_MESSAGES` | | `100` |
| `WHATSAPP_ENCRYPTION_ROTATION_MILLISECONDS` | | `604800000` |
| `WHATSAPP_ENCRYPTION_VERIFY_LEVELS_RECEIVE` | | `unverified` |
| `WHATSAPP_ENCRYPTION_VERIFY_LEVELS_SEND` | | `unverified` |
| `WHATSAPP_ENCRYPTION_VERIFY_LEVELS_SHARE` | | `cross-signed-tofu` |
| `WHATSAPP_FEDERATE_ROOMS` | | `TRUE` |
| `WHATSAPP_HOMESERVER_ADDRESS` | | `${HOMESERVER_ADDRESS}` |
| `WHATSAPP_HOMESERVER_DOMAIN` | | `${HOMESERVER_DOMAIN}` |
| `WHATSAPP_HOMESERVER_ENABLE_ASYNC_UPLOADS` | | `${HOMESERVER_ENABLE_ASYNC_UPLOADS}` |
| `WHATSAPP_HOMESERVER_HTTP_RETRY_COUNT` | | `${HOMESERVER_HTTP_RETRY_COUNT}` |
| `WHATSAPP_HOMESERVER_MESSAGE_SEND_CHECKPOINT_ENDPOINT` | | `null` |
| `WHATSAPP_HOMESERVER_SOFTWARE` | | `${HOMESERVER_SOFTWARE}` |
| `WHATSAPP_HOMESERVER_STATUS_ENDPOINT` | | `null` |
| `WHATSAPP_HOMESERVER_TLS_VERIFY` | | `${HOMESERVER_TLS_VERIFY}` |
| `WHATSAPP_INVITE_OWN_PUPPET_TO_PM` | | `` |
| `WHATSAPP_LISTEN_IP` | | `0.0.0.0` |
| `WHATSAPP_LISTEN_PORT` | | `29318` |
| `WHATSAPP_LOG_FILE` | | `whatsapp.log` |
| `WHATSAPP_LOG_LEVEL` | | `${LOG_LEVEL}` |
| `WHATSAPP_LOG_PATH` | | `${LOG_PATH}` |
| `WHATSAPP_LOG_TYPE` | | `${LOG_TYPE}` |
| `WHATSAPP_METRICS_LISTEN_IP` | | `127.0.0.1` |
| `WHATSAPP_METRICS_LISTEN_PORT` | | `9200` |
| `WHATSAPP_OS_NAME` | | `Mautrix-WhatsApp bridge` |
| `WHATSAPP_PERMISSIONS_ADMIN` | | `@admin:example.com` |
| `WHATSAPP_PERMISSIONS_RELAY` | | `*` |
| `WHATSAPP_PERMISSIONS_USER` | | `example.com` |
| `WHATSAPP_PERSONAL_FILTERING_SPACES` | | `false` |
| `WHATSAPP_PORTAL_MESSAGE_BUFFER` | | `128` |
| `WHATSAPP_REGISTRATION_FILE` | | `whatsapp-registration.yaml` |
| `WHATSAPP_REGISTRATION_PATH` | | `${REGISTRATION_PATH}` |
| `WHATSAPP_SEGMENT_API_KEY` | | `null` |
| `WHATSAPP_TEMPLATE_DISPLAYNAME` | | `{{if .BusinessName}}{{.BusinessName}}{{else if .PushName}}{{.PushName}}{{else}}{{.JID}}{{end}} (WA)` |
| `WHATSAPP_TEMPLATE_USERNAME` | | `whatsapp_{{.}}` |

### Networking

| Port  | Protocol | Description       |
| ----- | -------- | ----------------- |
| 28476 | tcp      | Telegram Bridge   |
| 29318 | tcp      | Whatsapp Bridge   |
| 29319 | tcp      | Facebook Bridge   |
| 29328 | tcp      | Signal Bridge     |
| 29330 | tcp      | Instagram Bridge  |
| 29335 | tcp      | Slack Bridge      |
| 29327 | tcp      | Twitter Bridge    |
| 3200  | tcp      | Facebook Metrics  |
| 4400  | tcp      | Instagram Metrics |
| 7465  | tcp      | Signal Metrics    |
| 7522  | tcp      | Slack Metrics     |
| 8476  | tcp      | Telegram Metrics  |
| 8989  | tcp      | Twitter Metrics   |
| 9200  | tcp      | Whatsapp Metrics  |

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
