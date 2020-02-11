use Mix.Config
config :issues, github_url: "https://api.github.com"

# コンパイル時に設定：debugは吐かない
config :logger, compile_time_purge_level: :info
