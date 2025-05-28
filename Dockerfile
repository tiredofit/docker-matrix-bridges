ARG DISTRO=alpine
ARG DISTRO_VARIANT=3.21

FROM docker.io/tiredofit/${DISTRO}:${DISTRO_VARIANT}
LABEL maintainer="Dave Conroy (github.com/tiredofit)"

ARG DISCORD_VERSION
ARG FACEBOOK_VERSION
ARG HOOKSHOT_VERSION
ARG INSTAGRAM_VERSION
ARG META_VERSION
ARG SIGNAL_VERSION
ARG SLACK_VERSION
ARG TELEGRAM_VERSION
ARG WHATSAPP_VERSION

ENV DISCORD_VERSION=${DISCORD_VERSION:-"v0.7.1"} \
    FACEBOOK_VERSION=${FACEBOOK_VERION:-"v0.5.1"} \
    HOOKSHOT_VERSION=${HOOKSHOT_VERSION:-"5.2.1"} \
    IMESSAGE_VERSION=${IMESSAGE_VERSION:-"master"} \
    INSTAGRAM_VERSION=${INSTAGRAM_VERSION:-"147c31aa332e6806a3349889acb7061a46366660"} \
    META_VERSION=${META_VERSION:-"v0.4.6"} \
    SIGNAL_VERSION=${SIGNAL_VERSION:-"v0.8.3"} \
    SLACK_VERSION=${SLACK_VERSION:-"v0.1.3"} \
    TELEGRAM_VERSION=${TELEGRAM_VERSION:-"v0.15.1"} \
    WHATSAPP_VERSION=${WHATSAPP_VERSION:-"v0.12.1"} \
    DISCORD_REPO_URL=https://github.com/mautrix/discord \
    FACEBOOK_REPO_URL=https://github.com/mautrix/facebook \
    HOOKSHOT_REPO_URL=https://github.com/matrix-org/matrix-hookshot \
    IMESSAGE_REPO_URL=https://github.com/mautrix/imessage \
    META_REPO_URL=https://github.com/mautrix/meta \
    SIGNAL_REPO_URL=https://github.com/mautrix/signal \
    SLACK_REPO_URL=https://github.com/mautrix/slack \
    TELEGRAM_REPO_URL=https://github.com/mautrix/telegram \
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
    package install .hookshot-build-deps \
                    build-base \
                    cargo \
                    nodejs \
                    openssl-dev \
                    rust \
                    yarn \
                    && \
    \
    package install .hookshot-run-deps \
                    nodejs \
                    yarn \
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
    \
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
                    #py3-brotli \
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
    cd /usr/src && \
    clone_git_repo "${DISCORD_REPO_URL}" "${DISCORD_VERSION}" && \
    mkdir -p /assets/config/discord && \
    go build -o /usr/bin/mautrix-discord && \
    cp -R example-config.yaml /assets/config/discord/example.config.yaml && \
    \
    cd /usr/src && \
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
    cd /usr/src && \
    clone_git_repo "${HOOKSHOT_REPO_URL}" "${HOOKSHOT_VERSION}" /usr/src/hookshot && \
    yarn \
        --ignore-scripts \
        --pure-lockfile \
        --network-timeout 600000 \
        && \
    node node_modules/esbuild/install.js && \
    yarn build && \
    mkdir -p /opt/hookshot && \
    cp -R package.json /opt/hookshot && \
    cp -R yarn.lock /opt/hookshot && \
    cp -R lib /opt/hookshot && \
    cp -R public /opt/hookshot && \
    \
    cd /usr/src && \
    clone_git_repo "${IMESSAGE_REPO_URL}" "${IMESSAGE_VERSION}" && \
    mkdir -p /assets/config/imessage && \
    go build -o /usr/bin/mautrix-imessage && \
    cp -R example-config.yaml /assets/config/imessage/example.config.yaml && \
    \
    cd /usr/src && \
    clone_git_repo "${META_REPO_URL}" "${META_VERSION}" && \
    export MAUTRIX_VERSION=$(cat go.mod | grep 'maunium.net/go/mautrix ' | awk '{ print $2 }') && \
    export GO_LDFLAGS="-s -w -X main.Tag=$(git describe --exact-match --tags 2>/dev/null) -X main.Commit=$(git rev-parse HEAD) -X 'main.BuildTime=`date '+%b %_d %Y, %H:%M:%S'`' -X 'maunium.net/go/mautrix.GoModVersion=$MAUTRIX_VERSION'" && \
    go build -o /usr/bin/mautrix-meta -ldflags "$GO_LDFLAGS" ./cmd/mautrix-meta "$@" && \
    #mkdir -p /assets/config/facebook /assets/config/instagram && \
    #cp -R example-config.yaml /assets/config/instagram/example.config.yaml && \
    #cp -R example-config.yaml /assets/config/facebook/example.config.yaml && \
    \
    cd /usr/src && \
    clone_git_repo "${SIGNAL_REPO_URL}" "${SIGNAL_VERSION}" && \
    cd pkg/libsignalgo/libsignal && \
    RUSTFLAGS="-Ctarget-feature=-crt-static" \
    RUSTC_WRAPPER="" \
    cargo build \
        -p libsignal-ffi \
        --profile=release \
        && \
    cd /usr/src/signal && \
    MAUTRIX_VERSION=$(cat go.mod | grep 'maunium.net/go/mautrix ' | awk '{ print $2 }') && \
    GO_LDFLAGS="-X main.Tag=$(git describe --exact-match --tags 2>/dev/null) -X main.Commit=$(git rev-parse HEAD) -X 'main.BuildTime=`date -Iseconds`' -X 'maunium.net/go/mautrix.GoModVersion=$MAUTRIX_VERSION'" && \
    LIBRARY_PATH=/usr/src/signal/pkg/libsignalgo/libsignal/target/release \
    go build -o /usr/bin/mautrix-signal ./cmd/mautrix-signal && \
    mkdir -p /assets/config/signal && \
    #cp -R example-config.yaml /assets/config/signal/example.config.yaml && \
    \
    cd /usr/src && \
    clone_git_repo "${SLACK_REPO_URL}" "${SLACK_VERSION}" && \
    MAUTRIX_VERSION=$(cat go.mod | grep 'maunium.net/go/mautrix ' | awk '{ print $2 }' | head -n1) && \
    GO_LDFLAGS="-s -w -X main.Tag=$(git describe --exact-match --tags 2>/dev/null) -X main.Commit=$(git rev-parse HEAD) -X 'main.BuildTime=`date -Iseconds`' -X 'maunium.net/go/mautrix.GoModVersion=$MAUTRIX_VERSION'" && \
    go build -ldflags="$GO_LDFLAGS" -o /usr/bin/mautrix-slack ./cmd/mautrix-slack "$@" && \
    mkdir -p /assets/config/slack && \
    \
    clone_git_repo "${TELEGRAM_REPO_URL}" "${TELEGRAM_VERSION}" && \
    pip3 install \
                --break-system-packages \
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
    cd /usr/src && \
    clone_git_repo "${WHATSAPP_REPO_URL}" "${WHATSAPP_VERSION}" && \
    MAUTRIX_VERSION=$(cat go.mod | grep 'maunium.net/go/mautrix ' | awk '{ print $2 }') && \
    GO_LDFLAGS="-s -w -X main.Tag=$(git describe --exact-match --tags 2>/dev/null) -X main.Commit=$(git rev-parse HEAD) -X 'main.BuildTime=`date -Iseconds`' -X 'maunium.net/go/mautrix.GoModVersion=$MAUTRIX_VERSION'" && \
    go build -ldflags="$GO_LDFLAGS" -o /usr/bin/mautrix-whatsapp ./cmd/mautrix-whatsapp && \
#    mkdir -p /assets/config/whatsapp && \
#    cp -R example-config.yaml /assets/config/whatsapp/example.config.yaml && \
    \
    chown matrix:matrix /assets/config/ && \
    package remove  .build-deps \
                    .discord-build-deps \
                    .hookshot-build-deps \
                    .imessage-build-deps \
                    .meta-build-deps \
                    .signal-build-deps\
                    .slack-build-deps \
                    .telegram-build-deps \
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

COPY install /
