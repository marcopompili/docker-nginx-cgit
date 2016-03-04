FROM emarcs/base-debian:jessie

MAINTAINER Marco Pompili "marco.pompili@emarcs.org"

RUN apt-get -q -q update && \
    apt-get -q -q -y install fcgiwrap git cgit && \
    apt-get -q -q -y install ca-certificates nginx gettext-base

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN useradd nginx

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80 443

RUN mkdir /srv/git

COPY cgitrc /etc/

COPY default.conf /etc/nginx/conf.d/

COPY startup /etc/minit/startup

VOLUME ["/srv/git"]
