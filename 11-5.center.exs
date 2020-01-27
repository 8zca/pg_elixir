defmodule MyString do
  def center(strs) do
    max_length = strs
    |> Enum.max_by(&String.length/1)
    |> String.length

    for x <- strs do
      x_length = String.length(x)
      pad = div(max_length - x_length, 2) + x_length
      IO.puts(String.pad_leading(x, pad, "\s"))
    end
  end
end

MyString.center(["abc", "abcabc", "aaaaa"])
MyString.center(["abc", "zebra", "elephant"])
