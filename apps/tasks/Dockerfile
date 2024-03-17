FROM ruby:3.2.2-slim

# Minimal requirements to run a Rails app
RUN apt-get update
RUN apt-get install -y --no-install-recommends build-essential \
    git \
    libpq-dev \
    tzdata \
    curl \
    bash \
    less \
    nodejs \
    libxml2-dev libxslt-dev \
    postgresql-client

ENV RAILS_ENV='production'
ENV RACK_ENV='production'


# Configure bundler
ENV LANG=C.UTF-8 \
  BUNDLE_JOBS=4 \
  BUNDLE_RETRY=3

# Upgrade RubyGems
RUN gem update --system

# Install Bundler
RUN gem install bundler
RUN bundle config build.nokogiri --use-system-libraries

# Create working directory
RUN mkdir -p /app
WORKDIR /app

# Install dependencies
COPY .ruby-version Gemfile Gemfile.lock ./
RUN bundle install

# Copy application
COPY ./ .

# Entrypoint prepares the database.
ENTRYPOINT ["./bin/docker-entrypoint"]

# Start the server by default, this can be overwritten at runtime
EXPOSE 3000
CMD ["./bin/rails", "server"]