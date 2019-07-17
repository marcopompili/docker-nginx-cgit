FROM emarcs/debian-minit

MAINTAINER Marco Pompili "docker@mg.odd.red"

RUN apt-get -qq update && \
    apt-get -qy install gettext-base \
                        fcgiwrap git cgit highlight \
                        ca-certificates nginx gettext-base \
                        markdown python-docutils groff && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN useradd nginx

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80 443

RUN mkdir /srv/git

VOLUME ["/srv/git"]
VOLUME ["/var/cache/cgit"]

COPY cgitrc.template /etc/

COPY syntax-highlighting.sh /usr/lib/cgit/filters/

COPY default.conf /etc/nginx/sites-available/default

COPY 404.html /usr/share/nginx/html/
COPY 401.html /usr/share/nginx/html/

COPY startup /etc/minit/

ENV CGIT_TITLE "My cgit interface"
ENV CGIT_DESC "Super fast interface to my git repositories"
ENV CGIT_VROOT "/"
ENV CGIT_SECTION_FROM_STARTPATH 0
ENV CGIT_MAX_REPO_COUNT 50
