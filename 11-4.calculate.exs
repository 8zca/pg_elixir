defmodule Math do
  def calculate(str) do
    list = Enum.chunk_by(str, &(&1 in ' '))
    [num1, op, num2] = Enum.filter(list, &(&1 != ' '))
    _calc(List.to_integer(num1), op, List.to_integer(num2))
  end

  defp _calc(num1, '+', num2), do: num1 + num2
  defp _calc(num1, '-', num2), do: num1 - num2
  defp _calc(num1, '*', num2), do: num1 * num2
  defp _calc(num1, '/', num2), do: num1 / num2
end

IO.inspect(Math.calculate('123 - 23'))
IO.inspect(Math.calculate('11 * 9'))
