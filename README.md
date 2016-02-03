# docker-nginx-cgit

A docker image for cgit running over nginx.

This is a docker image for cgit, a lightweight web interface for git.

## Installation

Download this image from the docker hub:

```shell
docker pull emarcs/nginx-cgit
```

Then wait for docker to do its magic.

## Usage

To launch the container, just the run command like this:

```shell

docker run -d -p 2340:80 \
  --name nginx-git-srv \
  -v /git:/srv/git \
  emarcs/nginx-git

```

In the above example the **/git** folder of the the host
is used inside the **/srv/git** folder of the container,
the HTTP port is mapped on the host on port **2340**.
