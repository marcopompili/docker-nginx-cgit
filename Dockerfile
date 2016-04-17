FROM emarcs/debian-minit:jessie

MAINTAINER Marco Pompili "docker@emarcs.org"

RUN apt-get -qq update && \
    apt-get -qy install gettext-base && \
    apt-get -qy install fcgiwrap git cgit highlight && \
    apt-get -qy install ca-certificates nginx gettext-base

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN useradd nginx

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80 443

RUN mkdir /srv/git

VOLUME ["/srv/git"]

COPY cgitrc.template /etc/

COPY syntax-highlighting.sh /usr/lib/cgit/filters/

COPY default.conf /etc/nginx/sites-available/default

COPY 404.html /usr/share/nginx/html/
COPY 401.html /usr/share/nginx/html/

COPY startup /etc/minit/

ENV CGIT_TITLE "My cgit interface"
ENV CGIT_DESC "Super fast interface to my git repositories"
ENV CGIT_SECTION_FROM_STARTPATH 0
