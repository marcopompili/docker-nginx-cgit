FROM nginx:stable-alpine

LABEL maintainer="Marco Pompili"
LABEL email="docker@mg.odd.red"

RUN apk --update --no-cache add fcgiwrap spawn-fcgi \
cgit highlight markdown groff

RUN mkdir /srv/git

VOLUME ["/srv/git", "/var/cache/cgit"]

COPY cgitrc.template /etc/

COPY syntax-highlighting.sh /usr/lib/cgit/filters/

COPY default.conf /etc/nginx/sites-available/default

COPY 404.html /usr/share/nginx/html/
COPY 401.html /usr/share/nginx/html/

COPY start.sh /

ENV CGIT_TITLE "My cgit interface"
ENV CGIT_DESC "Super fast interface to my git repositories"
ENV CGIT_VROOT "/"
ENV CGIT_SECTION_FROM_STARTPATH 0
ENV CGIT_MAX_REPO_COUNT 50

CMD ["/start.sh"]
