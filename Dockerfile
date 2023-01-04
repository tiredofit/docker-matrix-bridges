ARG ALPINE_VERSION=3.17

FROM docker.io/tiredofit/alpine:${ALPINE_VERSION}
LABEL maintainer="Dave Conroy (github.com/tiredofit)"

ARG DISCORD_VERSION
ARG FACEBOOK_VERSION
ARG GOOGLECHAT_VERSION
ARG INSTAGRAM_VERSION
ARG SIGNAL_VERSION
ARG SLACK_VERSION
ARG TELEGRAM_VERSION
ARG TWITTER_VERSION
ARG WHATSAPP_VERSION

ENV DISCORD_VERSION=${DISCORD_VERSION:-"main"} \
    FACEBOOK_VERSION=${FACEBOOK_VERSION:-"v0.4.1"} \
    GOOGLECHAT_VERSION=${GOGGLECHAT_VERSION:-"v0.4.0"} \
    INSTAGRAM_VERSION=${INSTAGRAM_VERSION:-"v0.2.2"} \
    SLACK_VERSION=${SLACK_VERSION:-"main"} \
    TELEGRAM_VERSION=${TELEGRAM_VERSION:-"v0.12.2"} \
    TWITTER_VERSION=${TWITTER_VERSION:-"v0.1.5"} \
    WHATSAPP_VERSION=${WHATSAPP_VERSION:-"v0.8.0"} \
    DISCORD_REPO_URL=https://github.com/mautrix/discord \
    FACEBOOK_REPO_URL=https://github.com/mautrix/facebook \
    GOOGLECHAT_REPO_URL=https://github.com/mautrix/googlechat \
    INSTAGRAM_REPO_URL=https://github.com/mautrix/instagram \
    SLACK_REPO_URL=https://github.com/mautrix/slack \
    SIGNAL_VERSION=${SIGNAL_VERSION:-"v0.4.2"} \
    SIGNAL_REPO_URL=https://github.com/mautrix/signal \
    TELEGRAM_REPO_URL=https://github.com/mautrix/telegram \
    TWITTER_REPO_URL=https://github.com/mautrix/twitter \
    WHATSAPP_REPO_URL=https://github.com/mautrix/whatsapp \
    FFMPEG_BINARY=/usr/bin/ffmpeg \
    IMAGE_NAME="tiredofit/matrix-bridges" \
    IMAGE_REPO_URL="https://github.com/tiredofit/matrix-bridges/"

RUN source assets/functions/00-container && \
    set -x && \
    addgroup -S -g 8008 matrix && \
    adduser -D -S -s /sbin/nologin \
            -h /home/matrix \
            -G matrix \
            -g "matrix" \
            -u 8008 matrix \
            && \
    mkdir -p /home/matrix && \
    chown matrix:matrix /home/matrix && \
    chown 700 /home/matrix && \
    \
    package update && \
    package upgrade && \
    package install .build-deps \
                    build-base \
                    git \
                    && \
    \
    package install .discord-build-deps \
                    go \
                    olm-dev \
                    && \
    \
    package install .facebook-build-deps \
                    libffi-dev  \
                    py3-pip \
                    py3-setuptools \
                    py3-wheel \
                    py3-pillow \
                    python3-dev \
                    && \
    \
    package install .facebook-run-deps \
                    ffmpeg \
                    py3-aiohttp \
                    py3-aiohttp-socks \
                    py3-cffi \
                    py3-commonmark \
                    py3-future \
                    py3-magic \
                    py3-olm \
                    py3-paho-mqtt \
                    py3-pillow \
                    py3-prometheus-client \
                    py3-pycryptodome \
                    py3-pysocks \
                    py3-ruamel.yaml \
                    py3-unpaddedbase64 \
                    && \
    \
    package install .googlechat-build-deps \
                    libffi-dev  \
                    py3-pip \
                    py3-setuptools \
                    py3-wheel \
                    py3-pillow \
                    python3-dev \
                    && \
    \
    package install .googlechat-run-deps \
                    py3-aiohttp \
                    py3-aiohttp-socks \
                    py3-cffi \
                    py3-commonmark \
                    py3-future \
                    py3-idna \
                    py3-magic \
                    py3-olm \
                    py3-pillow \
                    py3-prometheus-client \
                    py3-protobuf \
                    py3-pycryptodome \
                    py3-pysocks \
                    py3-ruamel.yaml \
                    py3-unpaddedbase64 \
                    && \
    \
    package install .instagram-build-deps \
                    libffi-dev  \
                    py3-pip \
                    py3-setuptools \
                    py3-wheel \
                    py3-pillow \
                    python3-dev \
                    && \
    \
    package install .instagram-run-deps \
                    py3-aiohttp \
                    py3-aiohttp-socks \
                    py3-cffi \
                    py3-commonmark \
                    py3-future \
                    py3-magic \
                    py3-olm \
                    py3-paho-mqtt \
                    py3-pillow \
                    py3-prometheus-client \
                    py3-pycryptodome \
                    py3-pysocks \
                    py3-ruamel.yaml \
                    py3-unpaddedbase64 \
                    && \
    \
    package install .signal-build-deps \
                    libffi-dev  \
                    py3-pip \
                    py3-setuptools \
                    py3-wheel \
                    py3-pillow \
                    python3-dev \
                    && \
    \
    package install .signal-run-deps \
                    ffmpeg \
                    py3-aiohttp \
                    py3-cffi \
                    py3-commonmark \
                    py3-cryptography \
                    py3-future \
                    py3-h11 \
                    py3-idna \
                    py3-magic \
                    py3-olm \
                    py3-phonenumbers \
                    py3-pillow \
                    py3-prometheus-client \
                    py3-protobuf \
                    py3-pycryptodome \
                    py3-qrcode \
                    py3-rfc3986 \
                    py3-ruamel.yaml \
                    py3-sniffio \
                    py3-unpaddedbase64 \
                    python3 \
                    && \
    \
    package install .slack-build-deps \
                    go \
                    olm-dev \
                    && \
    \
    package install .telegram-build-deps \
                    libffi-dev  \
                    py3-pip \
                    py3-setuptools \
                    py3-setuptools-rust \
                    py3-wheel \
                    py3-pillow \
                    python3-dev \
                    && \
    \
    package install .telegram-run-deps \
                    #imageio
                    #py3-proglog \
                    #py3-telethon \ (outdated)
                    ffmpeg \
                    py3-aiohttp \
                    py3-brotli \
                    py3-cffi \
                    py3-commonmark \
                    py3-decorator \
                    py3-future \
                    py3-idna \
                    py3-magic \
                    py3-mako \
                    py3-numpy \
                    py3-olm \
                    py3-phonenumbers \
                    py3-pillow \
                    py3-pyaes \
                    py3-pycryptodome \
                    py3-pysocks \
                    py3-qrcode \
                    py3-requests \
                    py3-rsa \
                    py3-ruamel.yaml \
                    py3-tqdm \
                    py3-unpaddedbase64 \
                    && \
    \
    package install .twitter-build-deps \
                    libffi-dev  \
                    py3-pip \
                    py3-setuptools \
                    py3-wheel \
                    py3-pillow \
                    python3-dev \
                    && \
    \
    package install .twitter-run-deps \
                    py3-pillow \
                    py3-aiohttp \
                    py3-magic \
                    py3-ruamel.yaml \
                    py3-commonmark \
                    py3-prometheus-client \
                    py3-olm \
                    py3-cffi \
                    py3-pycryptodome \
                    py3-unpaddedbase64 \
                    py3-future \
                    && \
    \
    package install .whatsapp-build-deps \
                    go \
                    olm-dev \
                    && \
    \
    package install .whatsapp-run-deps \
                    olm \
                    ffmpeg \
                    && \
    \
    package install .run-deps \
                    postgresql15-client \
                    sqlite \
                    && \
    \
    ##
    clone_git_repo "${DISCORD_REPO_URL}" "${DISCORD_VERSION}" && \
    mkdir -p /assets/config/discord && \
    go build -o /usr/bin/mautrix-discord && \
    cp -R example-config.yaml /assets/config/discord/example.config.yaml && \
    \
    clone_git_repo "${FACEBOOK_REPO_URL}" "${FACEBOOK_VERSION}" && \
    pip3 install \
                --upgrade \
                --no-cache-dir \
                -r requirements.txt \
                -r optional-requirements.txt \
                .[all] \
                && \
    \
    mkdir -p /assets/config/facebook && \
    cp -R mautrix_facebook/example-config.yaml /assets/config/facebook/example.config.yaml && \
    \
    clone_git_repo "${GOOGLECHAT_REPO_URL}" "${GOOGLECHAT_VERSION}" && \
    pip3 install \
                --upgrade \
                --no-cache-dir \
                -r requirements.txt \
                -r optional-requirements.txt \
                .[all] \
                && \
    \
    mkdir -p /assets/config/googlechat && \
    cp -R mautrix_googlechat/example-config.yaml /assets/config/googlechat/example.config.yaml && \
    \
    clone_git_repo "${INSTAGRAM_REPO_URL}" "${INSTAGRAM_VERSION}" && \
    pip3 install \
                --upgrade \
                --no-cache-dir \
                -r requirements.txt \
                -r optional-requirements.txt \
                .[all] \
                && \
    \
    mkdir -p /assets/config/instagram && \
    cp -R mautrix_instagram/example-config.yaml /assets/config/instagram/example.config.yaml && \
    \
    clone_git_repo "${SIGNAL_REPO_URL}" "${SIGNAL_VERSION}" && \
    pip3 install \
                --upgrade \
                --no-cache-dir \
                -r requirements.txt \
                -r optional-requirements.txt \
                .[all] \
                && \
    \
    mkdir -p /assets/config/signal && \
    cp -R mautrix_signal/example-config.yaml /assets/config/signal/example.config.yaml && \
    \
    clone_git_repo "${SLACK_REPO_URL}" "${SLACK_VERSION}" && \
    go build -o /usr/bin/mautrix-slack && \
    mkdir -p /assets/config/slack && \
    cp -R example-config.yaml /assets/config/slack/example.config.yaml && \
    \
    clone_git_repo "${TELEGRAM_REPO_URL}" "${TELEGRAM_VERSION}" && \
    pip3 install \
                --upgrade \
                --no-cache-dir \
                -r requirements.txt \
                -r optional-requirements.txt \
                .[all] \
                && \
    \
    mkdir -p /assets/config/telegram && \
    cp -R mautrix_telegram/example-config.yaml /assets/config/telegram/example.config.yaml && \
    \
    clone_git_repo "${WHATSAPP_REPO_URL}" "${WHATSAPP_VERSION}" && \
    go build -o /usr/bin/mautrix-whatsapp && \
    mkdir -p /assets/config/whatsapp && \
    cp -R example-config.yaml /assets/config/whatsapp/example.config.yaml && \
    \
    chown matrix:matrix /assets/config/ && \
    package remove \
                    .build-deps \
                    .discord-build-deps \
                    .facebook-build-deps \
                    .googlechat-build-deps \
                    .instagram-build-deps \
                    .signal-build-deps\
                    .slack-build-deps \
                    .telegram-build-deps \
                    .twitter-build-deps \
                    .whatsapp-build-deps \
                    && \
    package cleanup && \
    rm -rf /root/.cache \
           /root/.gitconfig \
           /root/go \
           && \
    rm -rf /usr/src/*

COPY install /
