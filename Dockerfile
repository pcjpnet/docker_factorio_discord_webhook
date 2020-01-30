FROM frolvlad/alpine-glibc:alpine-3.9

LABEL maintainer="https://github.com/pcjpnet/docker_factorio_discord_webhook"

ARG USER=factorio
ARG GROUP=factorio
ARG PUID=845
ARG PGID=845

ENV PORT=34197 \
    RCON_PORT=27015 \
    VERSION=0.17.79 \
    SHA1=7f127baf3cf01c6e545a9ca376dec1ac37468f8a \
    SAVES=/factorio/saves \
    CONFIG=/factorio/config \
    MODS=/factorio/mods \
    SCENARIOS=/factorio/scenarios \
    SCRIPTOUTPUT=/factorio/script-output \
    PUID="$PUID" \
    PGID="$PGID" \
    WEBHOOK="" \
    TEXT_START="Factorioサーバーが起動しました！" \
    TEXT_LOGIN="Factorioにユーザーがログインしました！" \
    TEXT_LOGOUT="Factorioからユーザーがログアウトしました！"

RUN set -ox pipefail \
    && archive="/tmp/factorio_headless_x64_$VERSION.tar.xz" \
    && mkdir -p /opt /factorio \
    && apk add --update --no-cache --no-progress bash binutils curl file gettext jq libintl pwgen shadow su-exec screen \
    && curl -sSL "https://www.factorio.com/get-download/$VERSION/headless/linux64" -o "$archive" \
    && echo "$SHA1  $archive" | sha1sum -c \
    || (sha1sum "$archive" && file "$archive" && exit 1) \
    && tar xf "$archive" --directory /opt \
    && chmod ugo=rwx /opt/factorio \
    && rm "$archive" \
    && ln -s "$SAVES" /opt/factorio/saves \
    && ln -s "$MODS" /opt/factorio/mods \
    && ln -s "$SCENARIOS" /opt/factorio/scenarios \
    && ln -s "$SCRIPTOUTPUT" /opt/factorio/script-output \
    && addgroup -g "$PGID" -S "$GROUP" \
    && adduser -u "$PUID" -G "$GROUP" -s /bin/sh -SDH "$USER" \
    && chown -R "$USER":"$GROUP" /opt/factorio /factorio

VOLUME /factorio

EXPOSE $PORT/udp $RCON_PORT/tcp

COPY files/ /

ENTRYPOINT ["/docker-entrypoint.sh"]
