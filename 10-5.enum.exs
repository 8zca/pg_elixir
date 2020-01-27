defmodule MyList do
  def all?([], _), do: true
  def all?([head | tail], func) do
    if func.(head) do
      all?(tail, func)
    else
      false
    end
  end

  def each([], _), do: true
  def each([head | tail], func) do
    func.(head)
    each(tail, func)
  end

  def filter([], _), do: []
  def filter([head | tail], func) do
    if func.(head) do
      [head | filter(tail, func)]
    else
      filter(tail, func)
    end
  end
end

IO.inspect(MyList.all?([1, 2, 3], &(&1 > 2)))
IO.inspect(MyList.all?([3, 4, 5], &(&1 > 2)))

MyList.each([1, 2, 3], &IO.puts(&1))

IO.inspect(MyList.filter([1, 2, 3, 4], &(&1 > 2)))
