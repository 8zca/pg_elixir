defmodule MyList do
  def flatten([]), do: []
  def flatten([head | tail]) do
    if is_list(head) do
      flatten(head) ++ flatten(tail)
    else
      [head] ++ flatten(tail)
    end
  end
end

IO.inspect(MyList.flatten([1, [2, 3, [4]], 5, [[[6]]]]))
#IO.inspect(MyList.flatten([1, [2]]))
