defmodule Stack2.Server do
  use GenServer

  def start_link(stash_pid) do
    { :ok, _pid } = GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
  end

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  def push(value) do
    GenServer.cast(__MODULE__, { :push, value })
  end

  # GenServerコールバック

  def init(stash_pid) do
    list = Stack2.Stash.get_value(stash_pid)
    { :ok, { list, stash_pid } }
  end

  # POP
  def handle_call(:pop, _from, { list, stash_pid }) do
    [head | tail] = list
    { :reply, head, { tail, stash_pid } }
  end

  # PUSH
  def handle_cast({ :push, value }, { list, stash_pid }) do
    { :noreply, { [value | list], stash_pid } }
  end

  def terminate(_reason, { list, stash_pid }) do
    Stack2.Stash.save_value(stash_pid, list)
  end
end
