defmodule Stack2.Stash do
  use GenServer

  @me __MODULE__

  def start_link(list) do
    IO.puts("start stash")
    GenServer.start_link(@me, list, name: @me)
  end

  def get do
    GenServer.call(@me, :get)
  end

  def update(list) do
    GenServer.cast(@me, { :update, list })
  end

  def handle_call(:get, _from, list) do
    { :reply, list, list }
  end

  def handle_cast({ :update, list }, _list) do
    { :noreply, list }
  end
end
