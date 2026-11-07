FROM ruby:3.3.5

# PostgreSQL接続に必要なパッケージ
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    postgresql-client \
    libpq-dev && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# 本番環境の設定
ENV RAILS_ENV=production \
    BUNDLE_WITHOUT="development:test" \
    RAILS_SERVE_STATIC_FILES=true \
    RAILS_LOG_TO_STDOUT=true

# Gemfileを先にコピーしてGemをインストール
COPY Gemfile Gemfile.lock ./

RUN bundle install

# アプリケーションをコピー
COPY . .

# 本番用アセットを事前コンパイル
RUN SECRET_KEY_BASE_DUMMY=1 bundle exec rails assets:precompile

# Renderのポート
EXPOSE 10000

# Railsサーバーを起動
CMD ["sh", "-c", "bundle exec rails server -b 0.0.0.0 -p ${PORT:-10000}"]