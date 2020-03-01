defmodule Sequence.Server do
  use GenServer

  def start_link(current_number) do
    # module名のname付きプロセスを生成
    GenServer.start_link(__MODULE__, current_number, name: __MODULE__)
  end

  def next_number do
    GenServer.call(__MODULE__, :next_number)
  end

  def increment_number(delta) do
    GenServer.cast(__MODULE__, { :increment_number, delta })
  end

  # GenServerから呼ばれる
  # handle_call(クライアントが渡した最初の引数, クライアントのPID, サーバの状態)
  def handle_call(:next_number, _from, current_number) do
    # :replyは固定. これで2つ目の引数が返答され、次の状態が3つ目の引数で決定される
    { :reply, current_number, current_number + 1 }
  end

  # handle_castは返答しない noreply
  # この場合受け取るのは2つの変数
  def handle_cast({ :increment_number, delta }, current_number) do
    # 返答しないため、 :noreplyと次の状態を定義して終わる
    { :noreply, current_number + delta }
  end

  def format_status(_reason, [ _pdict, state ]) do
    [data: [{ "state", "current state is #{inspect state}"}]]
  end
end


# iex(1)> {:ok, pid} = GenServer.start_link(Sequence.Server, 100)
# {:ok, #PID<0.134.0>}
# iex(2)> GenServer.call(pid, :next_number)
# 100
# iex(3)> GenServer.call(pid, :next_number)
# 101
# iex(4)> GenServer.cast(pid, {:increment_number, 200})
# :ok
# iex(5)> GenServer.call(pid, :next_number)
# 302

# start_linkをラップすると
# iex(12)> Sequence.Server.start_link(123)
# {:error, {:already_started, #PID<0.148.0>}}
# iex(13)> Sequence.Server.next_number
# 123
# iex(14)> Sequence.Server.next_number
# 124
# iex(15)> Sequence.Server.increment_number(50)
# :ok
# iex(16)> Sequence.Server.next_number
# 175
