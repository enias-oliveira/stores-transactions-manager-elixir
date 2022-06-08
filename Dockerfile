ARG ELIXIR_VERSION=1.13.4
ARG OTP_VERSION=24.2
ARG DEBIAN_VERSION=bullseye-20210902-slim
ARG BACKEND_SERVICE_URL

ARG BUILDER_IMAGE="elixir:1.12.3"
ARG RUNNER_IMAGE="debian"


FROM ${BUILDER_IMAGE} as backend-builder

# install build dependencies
RUN apt-get update -y && apt-get install -y build-essential git \
    && apt-get clean && rm -f /var/lib/apt/lists/*_*

# prepare build dir
WORKDIR /backend-app

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# set build ENV
ENV MIX_ENV="prod"

# install mix dependencies
COPY backend/mix.exs backend/mix.lock ./
RUN mix deps.get --only $MIX_ENV
RUN mkdir config

# copy compile-time config files before we compile dependencies
# to ensure any relevant config change will trigger the dependencies
# to be re-compiled.
COPY backend/config/config.exs backend/config/${MIX_ENV}.exs config/
RUN mix deps.compile

COPY backend/priv priv

COPY backend/lib lib

# Compile the release
RUN mix compile

# Changes to config/runtime.exs don't require recompiling the code
COPY backend/config/runtime.exs config/

COPY backend/rel rel
RUN mix release

# start a new build stage so that the final image will only contain
# the compiled release and other runtime necessities
FROM ${RUNNER_IMAGE} as backend

RUN apt-get update -y && apt-get install -y libstdc++6 openssl libncurses5 locales iputils-ping \
  && apt-get clean && rm -f /var/lib/apt/lists/*_*

# Set the locale
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

WORKDIR "/backend-app"
RUN chown nobody /backend-app

# set runner ENV
ENV MIX_ENV="prod"

# Only copy the final release from the build stage
COPY --from=backend-builder --chown=nobody:root /backend-app/_build/${MIX_ENV}/rel/backend ./

USER nobody

CMD ["/app/bin/server"]


FROM node:16-alpine AS frontend-deps
RUN apk add --no-cache libc6-compat
WORKDIR /frontend-app
COPY frontend/package.json frontend/package-lock.json ./
RUN npm ci

FROM node:16-alpine AS frontend-builder
WORKDIR /frontend-app
COPY --from=frontend-deps /frontend-app/node_modules ./node_modules

ENV BACKEND_SERVICE_URL=$BACKEND_SERVICE_URL

COPY frontend/ .
RUN npm run build

FROM node:16-alpine AS frontend-runner
WORKDIR /frontend-app
ENV NODE_ENV production
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

COPY --from=frontend-builder /frontend-app/public ./public
COPY --from=frontend-builder /frontend-app/package.json ./package.json

COPY --from=frontend-builder --chown=nextjs:nodejs /frontend-app/.next/standalone ./
COPY --from=frontend-builder --chown=nextjs:nodejs /frontend-app/.next/static ./.next/static

USER nextjs

EXPOSE 3000


FROM debian AS runner
RUN apt-get update
RUN apt-get -y install curl gnupg
RUN curl -sL https://deb.nodesource.com/setup_16.x  | bash -
RUN apt-get -y install nodejs
WORKDIR /app
COPY --from=frontend-runner /frontend-app/. ./frontend
COPY --from=backend /backend-app/. ./backend
