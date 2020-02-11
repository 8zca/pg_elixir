use Mix.Config
config :weathers, weathers_gov_url: "https://w1.weather.gov/xml/current_obs"

# コンパイル時に設定：debugは吐かない
config :logger, compile_time_purge_level: :info
