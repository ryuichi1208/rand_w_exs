defmodule Fibonacci do
 
  def fib(n) do
    fib_iter(0, 1, n, 1)
  end
 
  defp fib_iter(a, b, n, i) do
    if i > n do
      []
    else
      [a | fib_iter(b, a + b, n, i + 1)]
    end
  end
 
end
 
 
IO.inspect Fibonacci.fib(20)
