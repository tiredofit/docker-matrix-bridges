ARG ALPINE_VERSION=3.19
ARG DEBIAN_VERSION=bullseye

#FROM docker.io/tiredofit/debian:${DEBIAN_VERSION} as hookshot_builder
#LABEL maintainer="Dave Conroy (github.com/tiredofit)"

#ARG NODE_VERSION=18
#ENV HOOKSHOT_VERSION=${HOOKSHOT_VERSION:-"4.0.0"} \
#    HOOKSHOT_REPO_URL=https://github.com/matrix-org/matrix-hookshot \
#    PATH="/root/.cargo/bin:${PATH}"

#RUN source /assets/functions/00-container && \
#    set -x && \
#    curl -sSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - && \
#    echo "deb https://deb.nodesource.com/node_${NODE_VERSION}.x $(cat /etc/os-release |grep "VERSION=" | awk 'NR>1{print $1}' RS='(' FS=')') main" > /etc/apt/sources.list.d/nodejs.list && \
#    curl -sSL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
#    echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list && \
#    curl -sSL https://sh.rustup.rs -sSf | sh -s -- -y --profile minimal && \
#    package update && \
#    package upgrade && \
#    package install \
#                    build-essential \
#                    cmake \
#                    git \
#                    nodejs \
#                    yarn \
#                    && \
#    clone_git_repo "${HOOKSHOT_REPO_URL}" "${HOOKSHOT_VERSION}" /usr/src/hookshot && \
#    yarn \
#        --ignore-scripts \
#        --pure-lockfile \
#        --network-timeout 600000 \
#        && \
#    node node_modules/esbuild/install.js && \
#    yarn build

FROM docker.io/tiredofit/alpine:${ALPINE_VERSION}
LABEL maintainer="Dave Conroy (github.com/tiredofit)"

#COPY --from=hookshot_builder /usr/src/hookshot/yarn.lock /usr/src/hookshot/package.json  /opt/hookshot/

#ARG DISCORD_VERSION
#ARG FACEBOOK_VERSION
#ARG GOOGLECHAT_VERSION
#ARG HOOKSHOT_VERSION
#ARG INSTAGRAM_VERSION
ARG META_VERSION
ARG SIGNAL_VERSION
#ARG SIGNALD_VERSION
#ARG SIGNALDCTL_VERSION
#ARG SLACK_VERSION
#ARG TELEGRAM_VERSION
#ARG TWITTER_VERSION
ARG WHATSAPP_VERSION

#ENV DISCORD_VERSION=${DISCORD_VERSION:-"v0.6.3"} \
    #GOOGLECHAT_VERSION=${GOGGLECHAT_VERSION:-"v0.5.0"} \
    #HOOKSHOT_VERSION=${HOOKSHOT_VERSION:-"2.5.0"} \
ENV DISCORD_VERSION=${DISCORD_VERSION:-"v0.6.5"} \
    FACEBOOK_VERSION=${FACEBOOK_VERSION:-"v0.5.1"} \
    FACEBOOK_REPO_URL=https://github.com/mautrix/facebook \
    IMESSAGE_VERSION=$IMESSAGE_VERSION:-"master"} \
    META_VERSION=${META_VERSION:-"v0.1.0"} \
    SIGNAL_VERSION=${SIGNAL_VERSION:-"v0.5.0"} \
    SLACK_VERSION=${SLACK_VERSION:-"a9ba2f9249bdc5df69a1349122d1769e7e48c9e1"} \
    #TELEGRAM_VERSION=${TELEGRAM_VERSION:-"v0.15.2"} \
    WHATSAPP_VERSION=${WHATSAPP_VERSION:-"v0.10.5"} \
    DISCORD_REPO_URL=https://github.com/mautrix/discord \
    #GOOGLECHAT_REPO_URL=https://github.com/mautrix/googlechat \
    #HOOKSHOT_REPO_URL=https://github.com/matrix-org/matrix-hookshot \
    IMESSAGE_REPO_URL=https://github.com/mautrix/imessage \
    META_REPO_URL=https://github.com/mautrix/meta \
    SIGNAL_REPO_URL=https://github.com/mautrix/signal \
    SLACK_REPO_URL=https://github.com/mautrix/slack \
    #TELEGRAM_REPO_URL=https://github.com/mautrix/telegram \
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
    package install .discord-run-deps \
                    olm \
                    ffmpeg \
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
    package install .imessage-build-deps \
                    go \
                    olm-dev \
                    && \
    \
    package install .imessage-run-deps \
                    olm \
                    ffmpeg \
                    && \
    #package install .hookshot-run-deps \
    #                nodejs \
    #                && \
    #                \
    #package install .instagram-build-deps \
    #                libffi-dev  \
    #                py3-pip \
    #                py3-setuptools \
    #                py3-wheel \
    #                py3-pillow \
    #                python3-dev \
    #                && \
    #\
    #package install .instagram-run-deps \
    #                py3-aiohttp \
    #                py3-aiohttp-socks \
    #                py3-cffi \
    #                py3-commonmark \
    #                py3-future \
    #                py3-magic \
    #                py3-olm \
    #                py3-paho-mqtt \
    #                py3-pillow \
    #                py3-prometheus-client \
    #                py3-pycryptodome \
    #                py3-pysocks \
    #                py3-ruaommentsmel.yaml \
    #                py3-unpaddedbase64 \
    #                && \
    #\
    package install .meta-build-deps \
                    go \
                    olm-dev \
                    && \
    \
    package install .meta-run-deps \
                    olm \
                    ffmpeg \
                    && \
    \
    package install .signal-build-deps \
                    cargo \
                    clang-dev \
                    cmake \
                    g++ \
                    git \
                    go \
                    make \
                    musl-dev \
                    olm-dev \
                    protoc \
                    rust \
                    && \
    \
    package install .signal-run-deps \
                    olm \
                    ffmpeg \
                    && \
    \
    package install .slack-build-deps \
                    go \
                    olm-dev \
                    && \
    \
    package install .slack-run-deps \
                    olm \
                    ffmpeg \
                    && \
    #package install .telegram-build-deps \
    #                libffi-dev  \
    #                py3-pip \
    #                py3-setuptools \
    #                py3-setuptools-rust \
    #                py3-wheel \
    #                py3-pillow \
    #                python3-dev \
    #                && \
    #\
    #package install .telegram-run-deps \
    #                #imageio
    #                #py3-proglog \
    #                #py3-telethon \ (outdated)
    #                ffmpeg \
    #                py3-aiohttp \
    #                #py3-brotli \
    #                py3-cffi \
    #                py3-commonmark \
    #                py3-decorator \
    #                py3-future \
    #                py3-idna \
    #                py3-magic \
    #                py3-mako \
    #                py3-numpy \
    #                py3-olm \
    #                py3-phonenumbers \
    #                py3-pillow \
    #                py3-pyaes \
    #                py3-pycryptodome \
    #                py3-pysocks \
    #                py3-qrcode \
    #                py3-requests \
    #                py3-rsa \
    #                py3-ruamel.yaml \
    #                py3-tqdm \
    #                py3-unpaddedbase64 \
    #                && \
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
                    postgresql16-client \
                    sqlite \
                    && \
    \
    clone_git_repo "${DISCORD_REPO_URL}" "${DISCORD_VERSION}" && \
    mkdir -p /assets/config/discord && \
    go build -o /usr/bin/mautrix-discord && \
    cp -R example-config.yaml /assets/config/discord/example.config.yaml && \
    \
    clone_git_repo "${FACEBOOK_REPO_URL}" "${FACEBOOK_VERSION}" && \
    pip3 install \
                --break-system-packages \
                --upgrade \
                --no-cache-dir \
                -r requirements.txt \
                -r optional-requirements.txt \
                .[all] \
                && \
    \
    pip3 install --break-system-packages --no-cache-dir .[e2be] && \
    mkdir -p /assets/config/facebook && \
    cp -R mautrix_facebook/example-config.yaml /assets/config/facebook/example.config.yaml && \
    \
    clone_git_repo "${IMESSAGE_REPO_URL}" "${IMESSAGE_VERSION}" && \
    mkdir -p /assets/config/imessage && \
    go build -o /usr/bin/mautrix-imessage && \
    cp -R example-config.yaml /assets/config/imessage/example.config.yaml && \
    \
    clone_git_repo "${META_REPO_URL}" "${META_VERSION}" && \
    go build -o /usr/bin/mautrix-meta && \
    mkdir -p /assets/config/meta && \
    cp -R example-config.yaml /assets/config/meta/example.config.yaml && \
    \
    clone_git_repo "${SIGNAL_REPO_URL}" "${SIGNAL_VERSION}" && \
    cd pkg/libsignalgo/libsignal && \
    RUSTFLAGS="-Ctarget-feature=-crt-static" \
    RUSTC_WRAPPER="" \
    cargo build \
        -p libsignal-ffi \
        --profile=release \
        && \
    cd /usr/src/signal && \
    LIBRARY_PATH=/usr/src/signal/pkg/libsignalgo/libsignal/target/release \
    go build -o /usr/bin/mautrix-signal && \
    mkdir -p /assets/config/signal && \
    cp -R example-config.yaml /assets/config/signal/example.config.yaml && \
    \
    clone_git_repo "${SLACK_REPO_URL}" "${SLACK_VERSION}" && \
    go build -o /usr/bin/mautrix-slack && \
    mkdir -p /assets/config/slack && \
    cp -R example-config.yaml /assets/config/slack/example.config.yaml && \
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
                    .imesssage-build-deps \
                    .meta-build-deps \
                    .signal-build-deps\
                    .slack-build-deps \
                    #.telegram-build-deps \
                    .whatsapp-build-deps \
                    && \
    package cleanup && \
    rm -rf \
                /root/.cache \
                /root/.cargo \
                /root/.config \
                /root/.gitconfig \
                /root/.gradle \
                /root/go \
                /tmp/* \
                /usr/example-config.yaml \
                /usr/src/*

#COPY --from=hookshot_builder /usr/src/hookshot/lib /usr/src/hookshot/public /opt/hookshot/
COPY install /
