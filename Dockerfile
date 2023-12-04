# Use an official Ruby runtime as a parent image
FROM ruby:3.0.3

# Set the working directory in the container
ENV RAILS_ROOT $HOMEDIR/telemetry
WORKDIR $RAILS_ROOT

# Copy Gemfile and Gemfile.lock to the container
COPY Gemfile Gemfile.lock ./

# Install bundle dependencies
RUN gem install bundler
RUN bundle install

# Install Redis
RUN apt-get update && apt-get install -y redis-server

# Copy the rest of the application code to the container
COPY . .

# Expose port 3000 to the outside world
EXPOSE 3000

# Command to run your application
CMD ["rails", "server", "-b", "0.0.0.0"]
