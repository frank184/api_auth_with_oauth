FROM ruby:2.5

RUN apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y build-essential apt-transport-https libpq-dev nodejs yarn

RUN mkdir /api_auth_with_oauth
WORKDIR /api_auth_with_oauth

COPY Gemfile /api_auth_with_oauth/Gemfile
COPY Gemfile.lock /api_auth_with_oauth/Gemfile.lock

RUN bundle install

COPY yarn.lock /api_auth_with_oauth/yarn.lock

RUN yarn install

COPY . /api_auth_with_oauth
