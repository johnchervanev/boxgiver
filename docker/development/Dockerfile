FROM node:10.15.3-stretch-slim as node
FROM ruby:2.6.5-buster as build-base

COPY --from=node /usr/local/bin/node /usr/local/bin/node
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules

RUN ln -s /usr/local/bin/node /usr/local/bin/nodejs
RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm

ENV REFRESHED_AT 2019-09-20

RUN apt-get update && apt-get dist-upgrade -y

COPY script/setup-mysql-apt-repo.sh /root/
RUN /root/setup-mysql-apt-repo.sh
RUN apt-get install -y apt-utils mysql-client libmysqlclient-dev sphinxsearch

# Prevent GPG from trying to bind on IPv6 address even if there are none
RUN mkdir ~/.gnupg \
  && chmod 600 ~/.gnupg \
  && echo "disable-ipv6" >> ~/.gnupg/dirmngr.conf

RUN npm set unsafe-perm true

ENV GEM_HOME "/usr/local/bundle"
ENV BUNDLE_PATH "/usr/local/bundle"
ENV BUNDLE_BIN "$BUNDLE_PATH/bin"
ENV PATH $BUNDLE_BIN:$GEM_HOME/gems/bin:$PATH

RUN gem install bundler:1.17.3
RUN gem install foreman

WORKDIR /opt/app
