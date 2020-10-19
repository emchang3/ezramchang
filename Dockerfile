FROM starefossen/ruby-node:2-10

RUN gem install lei

WORKDIR /Users/EMC3/Projects/ezramchang

COPY . .

RUN bundle install
RUN npx gulp shrink

EXPOSE 4567

CMD puma -b tcp://0.0.0.0:4567
