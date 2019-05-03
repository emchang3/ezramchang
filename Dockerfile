FROM starefossen/ruby-node:2-10

RUN gem install lei

WORKDIR /Users/EMC3/Projects/test

COPY . .

RUN bundle install

EXPOSE 80

CMD puma -b tcp://0.0.0.0:80

