defmodule Link do
  import :timer, only: [sleep: 1]

  def child_process do
    exit("Child process")
  end

  def run do
    spawn_monitor(Link, :child_process, [])

    # monitorは1sまってDOWNをrecieve
    sleep(1000)

    receive do
      msg ->
        IO.puts("Message received: #{inspect msg}")
    after 1000 ->
      IO.puts("Nothing happed")
    end
  end
end

defmodule LinkRaise do
  import :timer, only: [sleep: 1]

  def child_process do
    raise "Error!!"
  end

  def run do
    spawn_monitor(LinkRaise, :child_process, [])

    # raiseは待たないがDOWNは1s待って受け取る
    sleep(1000)

    receive do
      msg ->
        IO.puts("Message received: #{inspect msg}")
    after 1000 ->
      IO.puts("Nothing happed")
    end
  end
end

# Message received: {:DOWN, #Reference<0.2673347024.3577217028.26123>, :process, #PID<0.97.0>, "Child process"}
Link.run()

# 22:31:52.344 [error] Process #PID<0.100.0> raised an exception
# ** (RuntimeError) Error!!
#    14-5.spawn_monitor.exs:27: LinkRaise.child_process/0
# Message received: {:DOWN, #Reference<0.4134971869.3309305861.101625>, :process, #PID<0.100.0>, {%RuntimeError{message: "Error!!"}, [{LinkRaise, :child_process, 0, [file: '14-5.spawn_monitor.exs', line: 27]}]}}
LinkRaise.run()
