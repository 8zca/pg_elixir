defmodule Link do
  import :timer, only: [sleep: 1]

  def child_process do
    raise "Error!!"
  end

  def run do
    spawn_link(Link, :child_process, [])

    sleep(500)

    receive do
      msg ->
        IO.puts("Message received: #{inspect msg}")
    after 1000 ->
      IO.puts("Nothing happed")
    end
  end
end

Link.run()

# 例外の場合は親がメッセージを受信することはない
# $ elixir 14-4.spawn_link_raise.exs
# ** (EXIT from #PID<0.92.0>) an exception was raised:
#     ** (RuntimeError) Error!!
#         14-4.spawn_link_raise.exs:5: Link.child_process/0
