FROM ruby:2.7

RUN apt-get update -qq && apt-get install -y motion gettext-base

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock /app/
RUN bundle install

COPY . /app

RUN envsubst < /app/motion_sample.conf > /app/motion.conf

CMD [ "motion", "-n", "-c", "/app/motion.conf" ]
