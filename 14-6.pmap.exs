defmodule Parallel do
  def pmap(collection, fun) do
    # scopeが異なるためmeに入れておく
    me = self()

    collection
    |> Enum.map(fn (elem) ->
         # 子プロセスでは親プロセスに対してメッセージを送る
         # ここでのself()は子プロセス
         spawn_link(fn -> (send me, { self(), fun.(elem) }) end)
       end)
    |> Enum.map(fn (pid) ->
         receive do { ^pid, result } -> result end
       end)
  end
end

IO.inspect(Parallel.pmap(1..10, &(&1 * &1)))
