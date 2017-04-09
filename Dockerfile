FROM ruby:2.3.1-alpine

ENV RAILS_ENV=production \
    NODE_ENV=production

WORKDIR /mastodon

RUN BUILD_DEPS=" \
    postgresql-dev \
    libxml2-dev \
    libxslt-dev \
    build-base" \
 && apk -U upgrade && apk add \
    $BUILD_DEPS \
    nodejs \
    libpq \
    libxml2 \
    libxslt \
    ffmpeg \
    file \
    imagemagick \
 && npm install -g npm@3 && npm install -g yarn

COPY yarn.lock /mastodon
COPY package.json /mastodon
RUN yarn
RUN npm cache clean

COPY Gemfile.lock /mastodon
COPY Gemfile /mastodon
RUN bundle install --deployment --without test development

RUN rm -rf /tmp/* /var/cache/apk/* && apk del $BUILD_DEPS

COPY . /mastodon

# VOLUME /mastodon/public/system /mastodon/public/assets
