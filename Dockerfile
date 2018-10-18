FROM elixir:latest

WORKDIR /opt/filament

ENV MIX_ENV prod

RUN mix local.hex --force

RUN mix local.rebar --force

COPY mix.* ./

RUN mix deps.get --only prod

RUN mix deps.compile

COPY . .

RUN mix escript.build

RUN chmod a+x filament

ENTRYPOINT ["./filament.sh"]