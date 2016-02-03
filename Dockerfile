FROM nginx

MAINTAINER Marco Pompili "marco.pompili@emarcs.org"

RUN apt-get update && \
    apt-get -q -y install fcgiwrap git cgit

RUN mkdir /srv/git

COPY cgitrc /etc/

COPY default.conf /etc/nginx/conf.d/

COPY entrypoint.sh /usr/local/bin/

VOLUME ["/srv/git"]

ENTRYPOINT ["entrypoint.sh"]
