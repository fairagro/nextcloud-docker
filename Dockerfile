# We expect NEXTCLOUD_VERSION to be a fpm-alpine version.
ARG NEXTCLOUD_VERSION=fpm-alpine
FROM nextcloud:${NEXTCLOUD_VERSION}
LABEL version=${NEXTCLOUD_VERSION}
RUN set -ex; \
    apk add --no-cache \
        postgresql16-client=16.6-r0 \
        imagemagick-svg=7.1.1.32-r0 \
        bzip2-dev=1.0.8-r6