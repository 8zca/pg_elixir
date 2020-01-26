# 最大公約数を求める
defmodule Gcd do
  def of(x, 0), do: x
  def of(x, y), do: of(y, rem(x, y))
end

IO.inspect(Gcd.of(100, 20))
IO.inspect(Gcd.of(14, 12))
