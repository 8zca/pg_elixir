defmodule MyList do
  def span(from, to) when from + 1 <= to do
    [from | span(from + 1, to)]
  end

  def span(from, _) do
    [from]
  end
end

IO.inspect(MyList.span(1, 10))
