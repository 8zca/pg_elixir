defmodule Ascii do
  def printable?(list) do
    Enum.all?(list, &check/1)
  end

  def check(x) do
    if x >= 32 && x <= 126, do: true, else: false
  end
end

IO.inspect(Ascii.printable?('abc_?'))
IO.inspect(Ascii.printable?('あいう'))

