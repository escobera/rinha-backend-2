FROM hexpm/elixir:1.16.1-erlang-26.2.1-alpine-3.19.1 as build

# install build dependencies
RUN apk add --update git build-base

RUN mkdir /app
WORKDIR /app

# install Hex + Rebar
RUN mix do local.hex --force, local.rebar --force

# set build ENV
ENV MIX_ENV=prod

# install mix dependencies
COPY mix.exs mix.lock ./
COPY config config
RUN mix deps.get --only $MIX_ENV
RUN mix deps.compile

# build project
COPY priv priv
COPY lib lib
RUN mix compile

# build release
# at this point we should copy the rel directory but
# we are not using it so we can omit it
# COPY rel rel
RUN mix release

# prepare release image
FROM alpine:3.19.1 AS app

# install runtime dependencies
RUN apk add --update bash openssl libstdc++

ENV MIX_ENV=prod

# prepare app directory
RUN mkdir /db
RUN mkdir /app
WORKDIR /app

# copy release to app container
COPY --from=build /app/_build/prod/rel/rinha2 .
COPY entrypoint.sh .
RUN chown -R nobody: /app
RUN chown -R nobody: /db
USER nobody

ENV HOME=/app
CMD ["bash", "/app/entrypoint.sh"]