defmodule Stack.Server do
  use GenServer

  @me __MODULE__

  def start_link(_) do
    IO.puts(@me)
    GenServer.start_link(@me, nil, name: @me)
  end

  def pop do
    GenServer.call(@me, :pop)
  end

  def push(value) do
    GenServer.cast(@me, { :push, value })
  end

  # GenServerコールバック

  def init(_) do
    { :ok, Stack.Stash.get() }
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

  def terminate(_reason, list) do
    Stack.Stash.update(list)
  end
end
