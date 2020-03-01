# スーパバイザ
defmodule Stack2.Supervisor do
  use Supervisor

  def start_link(initial_list) do
    # ここでプロセスを作り、PIDを受け取る
    result = { :ok, sup } = Supervisor.start_link(__MODULE__, initial_list)
    IO.puts("supervisor start")

    # stashワーカーを起動
    start_workers(sup, initial_list)
    result
  end

  def start_workers(sup, initial_list) do
    # stash用のプロセスを作る
    # worker(モジュール, [arg])
    { :ok, stash_pid } = Supervisor.start_child(sup, worker(Stack2.Stash, [initial_list]))
    IO.inspect(stash_pid)

    # サブ用のスーパバイザを作る
    # supervisor(モジュール, [arg])
    res = Supervisor.start_child(sup, supervisor(Stack2.SubSupervisor, [stash_pid]))
    #res = Supervisor.start_child(sup, supervisor(Stask2.SubSupervisor, [stash_pid]))
    IO.inspect(res)
  end

  def init(_) do
    supervise([], strategy: :one_for_one)
  end
end
