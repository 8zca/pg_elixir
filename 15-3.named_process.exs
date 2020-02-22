defmodule Ticker do
  @interval 2000
  @name :ticker

  def start do
    # プロセスの生成 __MODULE__はTickerを指す
    # generatorにわたす初期値は [], nil
    pid = spawn(__MODULE__, :generator, [[], nil])

    # pidを :ticker という名前で登録
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    # クライアントのプロセス pid を受け取り、{ :register, クライアントPID } を送る
    # 送り先は :ticker の名前をつけたサーバプロセス
    # ここで generator が呼ばれる
    send :global.whereis_name(@name), { :register, client_pid }
  end

  def generator(clients, index) do
    receive do
      # Clientからregisterされたらここに来る
      # 他のClientも受け取れるように配列（初期値は[]）に加える
      { :register, pid } ->
        index = case index do
                  nil -> 0
                  _ -> index
                end

        IO.puts "registering #{inspect pid} #{index}"

        generator([pid | clients], index)
    after
      # 2sごとにクライアントに送る
      @interval ->
        time = Time.utc_now
        IO.puts "#{index} #{time}"
        index = unless index == nil do
                  send Enum.at(clients, index), { :tick, "tock #{time}" }

                  # 次のindexを設定（循環する）
                  index = index + 1
                  if index >= length(clients), do: 0, else: index
                end
        generator(clients, index)
    end
  end
end

defmodule Client do
  def start do
    # プロセスの生成
    pid = spawn(__MODULE__, :receiver, [])
    # pidをサーバに登録
    Ticker.register(pid)
  end

  def receiver do
    receive do
      # サーバから {:tick, msg}で受け取る
      { :tick, msg } ->
        IO.puts msg
        receiver()
    end

  end
end

# term1
# $ iex --sname one
# > c("15-3.named_process.exs")
# > Node.connect :"two@xxxx"
# > Ticker.start

# term2
# $ iex --sname two
# > c("15-3.named_process.exs")
# > Client.start
