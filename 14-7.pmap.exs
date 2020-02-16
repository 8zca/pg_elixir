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
         receive do { _pid, result } -> result end
       end)
  end
end

rand_calc = fn num ->
  :timer.sleep(:rand.uniform(1000))
  num * num
end
# 掛け算のfnにランダムでsleepを入れるとばらばらになる: _pid の場合
IO.inspect(Parallel.pmap(1..100, &(rand_calc.(&1))))
