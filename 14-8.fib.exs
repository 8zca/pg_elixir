# フィボナッチを計算する
defmodule FibSolver do
  def fib(scheduler) do
    # schedulerへreadyを送る
    send scheduler, { :ready, self() }
    # schedulerからの応答を待つ
    receive do
      { :fib, n, client } ->
        # fibを計算して結果を返す
        send client, { :answer, n, fib_calc(n), self() }
        # 再利用できるようにする
        fib(scheduler)
      { :shutdown } ->
        exit(:normal)
    end
  end

  defp fib_calc(0), do: 0
  defp fib_calc(1), do: 1
  defp fib_calc(n), do: fib_calc(n-1) + fib_calc(n-2)
end

# スケジューラー
# フィボナッチに対して走らせるが、処理対象のことは何も知らない（何であってもいい）
defmodule Scheduler do
  # @param num_processes いくつプロセスを作るか
  # @param module 何のプロセスを作るのかの対象モジュール(ここではScheduler)
  # @param func 指定したmoduleのメソッド
  # @param to_calculate 処理対象のリスト
  def run(num_processes, module, func, to_calculate) do
    (1..num_processes)
    # spawnでプロセスの生成 spawn(FibSolver, :fib, self())
    |> Enum.map(fn(_) -> spawn(module, func, [self()]) end)
    # 各プロセスに対して処理対象のリストを渡す
    |> schedule_processes(to_calculate, [])
  end

  def schedule_processes(processes, queue, results) do
    # FibSolverからの応答で分岐
    receive do
      # queue: to_caclulateがあるはキューの先頭の数字をもとに再度FibSolverにかけ続ける
      { :ready, pid } when length(queue) > 0 ->
        [ next | tail ] = queue
        send pid, { :fib, next, self() }
        schedule_processes(processes, tail , results)
      # キューがない場合はshutdownを送る
      { :ready, pid } ->
        send pid, { :shutdown }
        if length(processes) > 1 do
          # プロセスのリストを全部消していく
          schedule_processes(List.delete(processes, pid), queue, results)
        else
          Enum.sort(results, fn { n1, _ }, { n2, _ } -> n1 <= n2 end)
        end
      { :answer, number, result, _pid } ->
        schedule_processes(processes, queue, [{ number, result } | results])
    end
  end
end

to_process = [37, 37, 37, 37, 37, 37]

Enum.each 1..10, fn num_processes ->
  { time, result } = :timer.tc(
    Scheduler, :run,
    [num_processes, FibSolver, :fib, to_process]
  )

  if num_processes == 1 do
    IO.puts(inspect result)
    IO.puts("\n # time (s)")
  end
  :io.format("~2B ~.2f~n", [num_processes, time/1000000.0])
end

# time (s)
# 1 4.29
# 2 2.16
# 3 1.51
# 4 1.49
# 5 1.63
# 6 1.12
# 7 1.11
# 8 1.23
# 9 1.34
# 10 1.37
