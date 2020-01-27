defmodule MyString do
  def capitalize(str) do
    list = String.split(str, ".\s")
    _capitalize(list)
  end

  defp _capitalize([_ | []]), do: []

  defp _capitalize([head | tail]) do
    "#{String.capitalize(head)}. #{_capitalize(tail)}"
  end
end

IO.inspect(MyString.capitalize("oh. a DOG. woof. "))
