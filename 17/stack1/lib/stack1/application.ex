defmodule Stack1.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # モジュール.start_link(arg) の形式で呼ばれる
      # childrentに記載する形式は { モジュール, arg }
      # 引数なしの場合は モジュール だけでもよい
      # 今回は Stack1.Server.start_link([5, "cat", 9]) で呼び出す
      { Stack1.Server, [5, "cat", 9] }
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Stack1.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
