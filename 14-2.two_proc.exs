defmodule Proc do
  def greet do
    receive do
      {sender, msg} ->
        send sender, { :ok, msg }
        greet()
    end
  end
end

pid1 = spawn(Proc, :greet, [])
send pid1, { self(), "aaa" }

pid2 = spawn(Proc, :greet, [])
send pid2, { self(), "bbb" }

receive do
  {:ok, msg} ->
    IO.puts(msg)
end

receive do
  {:ok, msg} ->
    IO.puts(msg)
end

# 順番は決定的ではない
# $ elixir 14-2.two_proc.exs
# aaa
# bbb
# $ elixir 14-2.two_proc.exs
# bbb
# aaa
