FROM ruby:2.7-slim-buster

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    vim locales build-essential \
    libpq-dev libmariadb-dev curl npm && \
    npm install -g yarn n && \
    n 15.6

ENV APP_ROOT /app
WORKDIR $APP_ROOT

# gem のバージョンが変わった場合、ビルドし直せるように、ここで変更を検知する。
COPY Gemfile Gemfile.lock package.json yarn.lock $APP_ROOT/

RUN gem update --system && gem install bundler:2.1.4

RUN RAILS_ENV=development bundle install && yarn install --frozen-lockfile


# アプリのソースを追加するだけであれば、キャッシュが効くのでここだけでよい。
COPY  . $APP_ROOT/
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
