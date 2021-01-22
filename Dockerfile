FROM nginx:stable-alpine

LABEL maintainer="emarcs"
LABEL email="docker@mg.odd.red"

RUN apk --update --no-cache add fcgiwrap spawn-fcgi cgit python3 py-markdown py3-pygments highlight markdown groff

RUN mkdir /srv/git

ENV CGIT_TITLE="My cgit interface" CGIT_DESC="Super fast interface to my git repositories" CGIT_VROOT="/" CGIT_SECTION_FROM_STARTPATH=0 CGIT_MAX_REPO_COUNT=50

VOLUME ["/srv/git", "/var/cache/cgit"]

COPY cgitrc.template /etc

COPY syntax-highlighting.sh /usr/lib/cgit/filters/

COPY default.conf /etc/nginx/sites-available/default

COPY 404.html /usr/share/nginx/html/
COPY 401.html /usr/share/nginx/html/

COPY start.sh /

CMD ["/start.sh"]
