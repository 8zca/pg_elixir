defmodule Stack2.Stash do
  use GenServer

  def start_link(list) do
    IO.puts("start stash")
    { :ok, _pid } = GenServer.start_link(__MODULE__, list)
  end

  def save_value(pid, list) do
    GenServer.cast(pid, { :save_value, list })
  end

  def get_value(pid) do
    GenServer.call(pid, :get_value)
  end

  def handle_call(:get_value, _from, list) do
    { :reply, list, list }
  end

  def handle_cast({ :save_value, list }, _list) do
    { :noreply, list }
  end
end
