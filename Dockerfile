FROM ruby:3.1.2
ENV BUNDLER_VERSION=2.3.25
ENV APP_HOME /app
# Installation of dependencies
RUN apt-get update -qq \
  && apt-get install -y \
    nodejs \
    npm \
    yarn\
      # Needed for certain gems
    build-essential \
         # Needed for postgres gem
    libpq-dev \
    # The following are used to trim down the size of the image by removing unneeded data
  && apt-get clean autoclean \
  && apt-get autoremove -y \
  && rm -rf \
    /var/lib/apt \
    /var/lib/dpkg \
    /var/lib/cache \
    /var/lib/log
# Create a directory for our application
# and set it as the working directory
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
# Add our Gemfile and install gems
COPY Gemfile $APP_HOME/Gemfile
COPY Gemfile.lock $APP_HOME/Gemfile.lock
RUN gem install bundler -v ${BUNDLER_VERSION} && \
    bundle install

RUN rails tailwindcss:build


# Copy over our application code
ADD . $APP_HOME

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000


# Run our app
CMD RAILS_ENV=${RAILS_ENV} bundle exec rake db:migrate && bundle exec rails s -p ${PORT} -b '0.0.0.0'