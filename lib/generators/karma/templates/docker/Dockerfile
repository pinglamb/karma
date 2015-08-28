FROM phusion/passenger-ruby22:0.9.17
MAINTAINER <%= @maintainer %>

ENV HOME /root

CMD ["/sbin/my_init"]

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN apt-get update
# Upgrade Passenger
RUN apt-get install -y -o Dpkg::Options::="--force-confold" nginx-extras passenger

RUN npm install -g bower

RUN mkdir -p /home/app
WORKDIR /home/app

# Speed up docker by copywriting Gemfile to docker/freeze
ADD docker/freeze/Gemfile /home/app/Gemfile
ADD docker/freeze/Gemfile.lock /home/app/Gemfile.lock
RUN bundle install --binstubs --deployment --without development test --jobs 2
ADD Gemfile /home/app/Gemfile
ADD Gemfile.lock /home/app/Gemfile.lock
RUN bundle install --binstubs --deployment --without development test --jobs 2

ADD vendor/assets/bower.json /tmp/bower.json
WORKDIR /tmp
RUN bower install --allow-root

WORKDIR /home/app
ADD config.ru /home/app/config.ru
ADD Rakefile /home/app/Rakefile
ADD bin /home/app/bin
ADD public /home/app/public
ADD lib /home/app/lib
ADD vendor /home/app/vendor
ADD db /home/app/db
ADD config /home/app/config
ADD app /home/app/app

ADD docker/database.yml /home/app/config/database.yml

ENV RAILS_ENV production
RUN rm -Rf vendor/assets/bower_components
RUN mv /tmp/bower_components vendor/assets/bower_components

ADD docker/redis.yml /home/app/config/redis.yml

RUN rm -f /etc/service/nginx/down
ADD docker/nginx.conf /etc/nginx/sites-enabled/app.conf
ADD docker/nginx-env.conf /etc/nginx/main.d/nginx-env.conf

# Init Scripts
RUN mkdir -p /etc/my_init.d
ADD docker/init/01_permissions /etc/my_init.d/01_permissions
ADD docker/init/02_assets /etc/my_init.d/02_assets
# ADD docker/init/03_sidekiq /etc/my_init.d/03_sidekiq
RUN chmod +x /etc/my_init.d/*

VOLUME ["/home/app/log", "/home/app/public/assets", "/home/app/public/tmp/cache"]

EXPOSE 8888
