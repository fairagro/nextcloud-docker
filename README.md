# nextcloud-docker #

Our own flavor of the nextcloud docker image. It takes the
[official fpm-alpine docker image](https://hub.docker.com/_/nextcloud/) and installs further packages to enable the use
the the 'Backup' App and to remove several warnings shown by netxcloud.

There are github workflows that automatically build the image and publish them on
[Dockerhub](https://hub.docker.com/repository/docker/zalf/fairagro-nextcloud-docker/general) whenever a new netxcloud
image is published.

## Note on Versioning ##

This repo uses [Semantic Versioning](https://semver.org/). Every commit to the main branch will be tagged with a
version number of the form `v1.2.3`, where '1' is the major version, '2' the minor version and '3' the patch level.

The tool [`GitVersion`](https://gitversion.net/) is used to automatically create new versions. It is triggered by the
`Docker Build` workflow that also actually creates the git tags. To define how to increase the version, `GitVersion`
is configured to interpret [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/). So you are expected
to write commit messages that conform to this spec.

A conventional commit message looks like this:

```text
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

Allowed types are: 'build', 'chore', 'ci', 'docs', 'feat', 'fix', 'style', 'refactor', 'perf' and 'test'.
Each type denotes a corresponding change. All types except 'feat' (for feature) will induce an increase of the patch level,
whereas 'feat' will increase the minor version.

To increase the major version, you have to add a '!' to the type or add this to the footer:

```text
BREAKING CHANGE: <description>
```

The scope denotes the part of your project you're working on -- e.g 'frontend', 'backend', 'parser', etc. Currently there are no defined scopes
for this repo.

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
