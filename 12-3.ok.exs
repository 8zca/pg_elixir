ok! = fn
  {:ok, data} -> data
  e -> raise inspect(e)
end

ok!.(File.open("somefile"))
ok!.(File.open("12-1.fizzbuzz.exs"))
