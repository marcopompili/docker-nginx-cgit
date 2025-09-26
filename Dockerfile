FROM debian:13

LABEL maintainer="Marco Pompili"
LABEL email="docker@mg.odd.red"

RUN apt-get -qq update && \
    apt-get -qy install gettext-base \
        fcgiwrap git cgit highlight \
        ca-certificates nginx gettext-base \
        markdown python3-markdown python3-docutils groff && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN useradd nginx

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80 443

RUN mkdir /srv/git

VOLUME ["/srv/git", "/var/cache/cgit"]

ENV CGIT_TITLE="My cgit interface" CGIT_DESC="Super fast interface to my git repositories" CGIT_VROOT="/" CGIT_SECTION_FROM_STARTPATH=0 CGIT_MAX_REPO_COUNT=50

COPY cgitrc.template /etc/

COPY syntax-highlighting.sh /usr/lib/cgit/filters/

COPY default.conf /etc/nginx/sites-available/default

COPY 404.html /usr/share/nginx/html/
COPY 401.html /usr/share/nginx/html/

COPY 99_start.sh /etc/my_init.d/
