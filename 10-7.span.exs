defmodule MyList do
  def span(from, to) when from + 1 <= to do
    [from | span(from + 1, to)]
  end

  def span(from, _) do
    [from]
  end
end

n = 10
res = for x <- MyList.span(2, n), Enum.all?(MyList.span(2, x - 1), &(rem(x, &1) != 0)), do: x
IO.inspect(res)
