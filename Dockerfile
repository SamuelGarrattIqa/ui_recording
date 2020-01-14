FROM ruby:2.6
MAINTAINER Samuel Garratt

# Required ruby gems
RUN mkdir /mysuite
WORKDIR /mysuite
COPY Gemfile /mysuite/Gemfile
COPY Gemfile.lock /mysuite/Gemfile.lock
RUN gem install bundler
RUN bundle install

# Add language settings to handle special characters
RUN export LANG=C.UTF-8
RUN export LANGUAGE=C.UTF-8
RUN export LC_ALL=C.UTF-8