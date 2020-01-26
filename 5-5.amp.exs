# Enum.map [1, 2, 3, 4], fn -> x + 2 end
res = Enum.map [1, 2, 3, 4], &(&1 + 2)
IO.inspect(res)

# Enum.each [1, 2, 3, 4], fn x -> IO.inspect x end
Enum.each [1, 2, 3, 4], &IO.inspect/1
