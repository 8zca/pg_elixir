defmodule Stack2.SubSupervisor do
  use Supervisor

  def start_link(stash_pid) do
    IO.puts("start sub supervisor")
    { :ok, _pid } = Supervisor.start_link(__MODULE__, stash_pid)
  end

  def init(stash_pid) do
    IO.puts("init sub supervisor")
    # これはだめ
    # children = [
    #   { Stack2.Server, [stash_pid] }
    # ]
    #
    # opts = [strategy: :one_for_one]
    # supervise(children, opts)

    # one_for_one: 失敗した子プロセスのみを再起動
    child = [ worker(Stack2.Server, [stash_pid]) ]
    supervise(child, strategy: :one_for_one)
  end
end
