FROM hidakatsuya/redmine-base:3.1

COPY . plugins/redmine_default_custom_query

RUN bundle install
RUN bundle exec rake generate_secret_token
RUN bundle exec rake db:migrate
RUN bundle exec rake redmine:plugins:migrate

RUN REDMINE_LANG=en bundle exec rake redmine:load_default_data
