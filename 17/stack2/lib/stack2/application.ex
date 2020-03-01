
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
    { :ok, _pid } = Stack2.Supervisor.start_link([5, "cat", 9])
  end
end
