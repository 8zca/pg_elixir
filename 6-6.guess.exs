# 2分探索法
defmodule Chop do
  def guess(n, n), do: IO.inspect(n)

  def guess(n, first..last) do
    pivot = div(first + last, 2)
    IO.inspect("Is it #{pivot}")
    guess(n, new_range(n, first, last, pivot))
  end

  def new_range(n, first, _, pivot) when n < pivot do
    first..pivot
  end

  def new_range(n, _, last, pivot) when n > pivot do
    pivot..last
  end

  def new_range(n, _, _, pivot) when n == pivot do
    n
  end
end

Chop.guess(273, 1..1000)
