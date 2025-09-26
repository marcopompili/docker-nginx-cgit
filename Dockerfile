FROM nginx:stable

LABEL maintainer="Marco Pompili"
LABEL email="docker@mg.odd.red"

RUN apt-get -qq update && \
    apt-get -qy install git cgit highlight ca-certificates \
        markdown python3-markdown python3-docutils groff \
        fcgiwrap supervisor && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80 443

RUN mkdir /srv/git

VOLUME ["/srv/git", "/var/cache/cgit"]

ENV CGIT_TITLE="My cgit interface" \
    CGIT_DESC="Super fast interface to my git repositories" \
    CGIT_VROOT="/" \
    CGIT_SECTION_FROM_STARTPATH=0 \
    CGIT_MAX_REPO_COUNT=50

COPY cgitrc.template /etc/

COPY syntax-highlighting.sh /usr/lib/cgit/filters/

COPY default.conf /etc/nginx/conf.d/

COPY 404.html /usr/share/nginx/html/
COPY 401.html /usr/share/nginx/html/

COPY 90-cgit-envsubst-on-cgitrc.sh /docker-entrypoint.d/

COPY supervisord.conf /etc/supervisor/conf.d/

COPY docker-entrypoint.sh /

CMD ["supervisord", "-nc", "/etc/supervisor/conf.d/supervisord.conf"]
