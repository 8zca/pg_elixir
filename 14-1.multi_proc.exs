defmodule Chain do
  def counter(next_pid) do
    receive do
      n ->
        send next_pid, n + 1
    end
  end

  def create_processes(n) do
    # reduceで畳み込み
    # self() は自身のプロセスになる
    # 無名関数の第1引数は1..n, 第2引数で前回の処理結果（初回はself(), 2回目はspawnで生成されたプロセス）
    # 最初 <- n=1のプロセス <- n=2のプロセス .. n=10のプロセス になる
    last = Enum.reduce 1..n, self(), fn (_, send_to) -> spawn(Chain, :counter, [send_to]) end

    send last, 0

    receive do
      final_answer when is_integer(final_answer) ->
        "Result is #{final_answer}"
    end
  end

  def run(n) do
    IO.puts(inspect :timer.tc(Chain, :create_processes, [n]))
  end
end

Chain.run(10)
Chain.run(10_000)
