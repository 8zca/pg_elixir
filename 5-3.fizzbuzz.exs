fizzbuzz_judge = fn
  0, 0, _ -> "FizzBuzz"
  0, _, _ -> "Fizz"
  _, 0, _ -> "Buzz"
  _, _, c -> c
end

fizzbuzz = fn n ->
  fizzbuzz_judge.(rem(n, 3), rem(n, 5), n)
end

IO.inspect(fizzbuzz.(10))
IO.inspect(fizzbuzz.(11))
IO.inspect(fizzbuzz.(12))
IO.inspect(fizzbuzz.(13))
