FROM ruby:latest
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /notes-back-07
WORKDIR /notes-back-07
COPY Gemfile /notes-back-07/Gemfile
COPY Gemfile.lock /notes-back-07/Gemfile.lock
RUN bundle install
COPY . /notes-back-07

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]