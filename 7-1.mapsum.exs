defmodule MyList do
  def mapsum(list, func), do: _mapsum(list, 0, func)

  defp _mapsum([], value, _), do: value

  defp _mapsum([head | tail], value, func) do
    value + _mapsum(tail, func.(head), func)
  end
end

IO.inspect(MyList.mapsum([1, 2, 3], &(&1 * &1)))
