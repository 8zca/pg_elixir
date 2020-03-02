
# トップレベルモジュール
defmodule Stack.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  # mix.exs の application で起動設定されている
  def start(_type, _args) do
    IO.puts("start")
    children = [
      { Stack.Stash, [5, "cat", 9] },
      { Stack.Server, nil }
    ]
    opts = [strategy: :one_for_one, name: Stack.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
