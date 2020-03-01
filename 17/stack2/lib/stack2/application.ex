
# トップレベルモジュール
defmodule Stack2.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  # mix.exs の application で起動設定されている
  def start(_type, _args) do
    # スーパバイザを起動
    # start_linkは自前のメソッド
    IO.puts("start")
    children = [
      { Stack2.Stash, [5, "cat", 9] },
      { Stack2.Server, nil }
    ]
    opts = [strategy: :one_for_one, name: Stack2.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
