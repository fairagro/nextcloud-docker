# nextcloud-docker
Our own flavor of a nextcloud docker image

## Test build and run ##

```bash
docker build --build-arg NEXTCLOUD_VERSION=28.0.12-fpm-alpine -t nextcloud-test .
docker run -it --rm nextcloud-test -- sh
```