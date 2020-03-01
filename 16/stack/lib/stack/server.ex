defmodule Stack.Server do
  use GenServer

  def start_link(initial_list) do
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

# iex(2)> Stack.Server.start_link([5, "cat", 9])
# {:ok, #PID<0.181.0>}
# iex(3)> Stack.Server.push("dog")
# :ok
# iex(4)> Stack.Server.pop
# "dog"
# iex(5)> Stack.Server.pop
# 5
