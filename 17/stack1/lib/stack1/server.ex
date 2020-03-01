defmodule Stack1.Server do
  use GenServer

  def start_link(initial_list) do
    IO.puts("start_linkkk")
    GenServer.start_link(__MODULE__, initial_list, name: __MODULE__)
  end

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  def push(value) do
    GenServer.cast(__MODULE__, { :push, value })
  end

  # POP
  def handle_call(:pop, _from, list) do
    [head | tail] = list
    { :reply, head, tail }
  end

  # PUSH
  def handle_cast({ :push, value }, list) do
    { :noreply, [value | list] }
  end

  def terminate(reason, state) do
    IO.puts("terminate")
    IO.inspect(reason)
    IO.inspect(state)
  end
end


# iex(1)> Stack1.Server.pop
# 5
# iex(2)> Stack1.Server.pop
# "cat"
# iex(3)> Stack1.Server.pop
# 9
