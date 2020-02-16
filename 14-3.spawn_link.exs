defmodule Link do
  import :timer, only: [sleep: 1]

  def child_process do
    exit("Child process")
  end

  def run do
    spawn_link(Link, :child_process, [])

    # ここで1sまってもrecieveは関係なく子プロセスから通知を受けるので即終わる
    sleep(1000)

    receive do
      msg ->
        IO.puts("Message received: #{inspect msg}")
    after 1000 ->
      IO.puts("Nothing happed")
    end
  end
end

Link.run()
