# docker-nginx-cgit

A Docker image for Cgit running over Nginx.

[![](https://badge.imagelayers.io/emarcs/nginx-cgit:latest.svg)](https://imagelayers.io/?images=emarcs/nginx-cgit:latest 'Get your own badge on imagelayers.io')

This is a docker image for Cgit, a lightweight web interface for git.

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

### Using a custom Nginx configuration

An example using docker-compose of how to mount a custom
configuration for Nginx:

```ymp
test_srv:
  image: emarcs/nginx-cgit
  ports:
    - 8181:80
  volumes:
    - /srv/git:/srv/git
    # custom nginx configuration
    #- ./default.conf:/etc/nginx/sites-available/default
```
