defmodule MyList do
  def caesar([], _), do: []

  def caesar([head | tail], n) when head + n <= 122 do
    [head + n | caesar(tail, n)]
  end

  def caesar([head | tail], n) do
    # z: 122
    # a: 97
    s = head - 122 + n + 97 - 1
    [s| caesar(tail, n)]
  end
end

IO.puts(MyList.caesar('ryvkve', 13))
