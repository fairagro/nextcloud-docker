# nextcloud-docker
Our own flavor of a nextcloud docker image

## Test build and run ##

```bash
docker build --build-arg NEXTCLOUD_VERSION=28.0.12-fpm-alpine -t nextcloud-test .
docker run -it --rm nextcloud-test -- sh
```

## Find out the latest official Nextcloud image version ##

There are two ways to find out the  latest image version:

1. Download the latest version and inspect the image. This is more reliable in the sense that annotations within the image
   can be trusted more than image tags that are only stored in the docker registry. The downside
   is that the image needs to be downloaded, which can be resource-intensive task.

    ```bash
    docker manifest inspect -v nextcloud:fpm-alpine | \
        jq -r '.[] | select(.Descriptor.platform.os == "linux" and .Descriptor.platform.architecture == "amd64") | .OCIManifest.annotations["org.opencontainers.image.version"]'
    ```

2. Query dockerhub for the latest vesion.

    ```bash
    curl -L --fail "https://hub.docker.com/v2/repositories/library/nextcloud/tags/?page_size=1000" | \
        jq '.results | .[] | .name' -r | \
        sed -n '/[0-9]\+.[0-9]\+.[0-9]\+-fpm-alpine/p' | \
        sort --version-sort | \
        tail -n 1
    ```
