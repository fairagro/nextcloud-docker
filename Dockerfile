# We expect NEXTCLOUD_VERSION to be a fpm-alpine version.
ARG NEXTCLOUD_VERSION=fpm-alpine
FROM nextcloud:${NEXTCLOUD_VERSION}
LABEL version=${NEXTCLOUD_VERSION}
# Unfortunately we're unable to pin package versions as they're
# depending on the underlying alpine version. This alpine version
# may change depending on the nextcloud version and we need to
# be able to build the docker image on different nextcloud versions.
RUN set -ex; \
    apk add --no-cache \
        postgresql-client \
        imagemagick-svg \
        bzip2-dev \
        libpq-dev; \
    docker-php-ext-install bz2; \
    docker-php-ext-install pgsql