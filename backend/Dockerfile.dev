FROM bitwalker/alpine-elixir-phoenix:latest

RUN apk add postgresql-client && \
    apk add inotify-tools && \
    apk add bash

WORKDIR /app

COPY entrypoint.sh mix.exs mix.lock ./

RUN chmod +x /app/entrypoint.sh

RUN mix deps.get

EXPOSE 4000

CMD ./app/entrypoint.sh
