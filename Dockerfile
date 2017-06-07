FROM ruby:2.3.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /todos-api
WORKDIR /todos-api
ADD Gemfile /todos-api/Gemfile
ADD Gemfile.lock /todos-api/Gemfile.lock
RUN bundle install
ADD . /todos-api