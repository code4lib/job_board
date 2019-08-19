FROM phusion/passenger-customizable:1.0.6

RUN /pd_build/nodejs.sh
RUN /pd_build/ruby-2.6.*.sh

# Set correct environment variables.
ENV HOME /root

RUN rm -f /etc/service/nginx/down
RUN rm /etc/nginx/sites-enabled/default

WORKDIR /home/app/webapp

ADD . /home/app/webapp


ADD docker/webapp.conf /etc/nginx/sites-enabled/default
ADD docker/secret_key.conf /etc/nginx/main.d/secret_key.conf
ADD docker/settings/production.yml /home/app/webapp/config/settings/production.yml

RUN bundle install --deployment
RUN SECRET_KEY_BASE=x rake assets:precompile
RUN SECRET_KEY_BASE=x bundle exec whenever --update-cron
RUN chown app -R /home/app/webapp/log /home/app/webapp/db
RUN chmod u+wr -R /home/app/webapp/log /home/app/webapp/db

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]
