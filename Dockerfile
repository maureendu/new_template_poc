FROM ruby:3.1.0

RUN apt-get update -qq && apt-get install -y build-essential
# # Install the database packages
# sudo apt-get install -y mysql-server mysql-client libmysqlclient-dev

# # Pick a database root password (can be anything), type it and press enter
# # Retype the database root password and press enter

# # Secure your installation.
# sudo mysql_secure_installation


RUN mkdir /app
WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install
ADD . /app
