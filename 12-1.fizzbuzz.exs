defmodule FizzBuzz do
  def go(n), do: Enum.map(1..n, &fizzbuzz/1)
  defp fizzbuzz(n) do
    case [n, rem(n, 3), rem(n, 5)] do
      [_, 0, 0] -> "FizzBuzz"
      [_, 0, _] -> "Fizz"
      [_, _, 0] -> "Buzz"
      [n, _, _] -> n
    end
  end
end

IO.inspect(FizzBuzz.go(15))
