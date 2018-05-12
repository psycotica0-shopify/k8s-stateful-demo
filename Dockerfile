FROM ruby

WORKDIR /app
COPY Gemfile Gemfile.lock app.rb ./
RUN bundle install
CMD ["bundle", "exec", "ruby", "app.rb", "-o", "0.0.0.0"]
