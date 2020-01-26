prefix = fn first ->
  fn second -> "#{first} #{second}" end
end

mrs = prefix.("Mrs")
IO.inspect(mrs.("Smith"))

IO.inspect(prefix.("Hello").("world"))
