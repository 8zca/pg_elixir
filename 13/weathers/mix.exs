defmodule Weathers.MixProject do
  use Mix.Project

  def project do
    [
      app: :weathers,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      escript: escript_config(),
      name: "Weathers",
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :httpoison]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      { :httpoison, "~> 1.6" }
    ]
  end

  defp escript_config do
    [
      main_module: Weathers.CLI
    ]
  end
end
