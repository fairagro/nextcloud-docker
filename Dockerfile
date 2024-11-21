# We expect NEXTCLOUD_VERSION to be a fpm-alpine version.
ARG NEXTCLOUD_VERSION=fpm-alpine
FROM nextcloud:${NEXTCLOUD_VERSION}
RUN set -ex; \
    apk add --no-cache \
        postgresql-client