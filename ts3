defmodule Calc do
  def rpn(x) when is_bitstring(x) do
    [result] = List.foldl(String.split(x), [], &rpn/2)
    result
  end

  defp rpn("+", [n1, n2 | stack]), do: [n2 + n1 | stack]
  defp rpn("-", [n1, n2 | stack]), do: [n2 - n1 | stack]
  defp rpn("*", [n1, n2 | stack]), do: [n2 * n1 | stack]
  defp rpn("/", [n1, n2 | stack]), do: [n2 / n1 | stack]
  defp rpn("^", [n1, n2 | stack]), do: [:math.pow(n2, n1) | stack]
  defp rpn("ln", [n | stack]), do: [:math.log(n) | stack]
  defp rpn("log10", [n | stack]), do: [:math.log10(n) | stack]
  defp rpn("sum", [n1, n2 | stack]) when is_number(n2), do: rpn("sum", [n1 + n2 | stack])
  defp rpn("sum", stack), do: stack
  defp rpn("prod", [n1, n2 | stack]) when is_number(n2), do: rpn("prod", [n1 * n2 | stack])
  defp rpn("prod", stack), do: stack
  defp rpn(x, stack), do: [read(x) | stack]

  defp read(x) do
    # try do
    #   String.to_float(x)
    # rescue
    #   ArgumentError -> String.to_integer(x)
    # end
    char_list = String.to_char_list(x)
    case :string.to_float(char_list) do
      {:error, :no_float} -> :erlang.list_to_integer(char_list)
      {float_value, _} -> float_value
    end
  end

  def rpn_test do
    5 = rpn("2 3 +")
    87 = rpn("90 3 -")
    -4 = rpn("10 4 3 + 2 * -")
    -2.0 = rpn("10 4 3 + 2 * - 2 /")
    :ok = try do
            rpn("90 34 12 33 55 66 + * - +")
          rescue
            MatchError -> :ok
          end
    4037 = rpn("90 34 12 33 55 66 + * - + -")
    8.0 = rpn("2 3 ^")
    true = :math.sqrt(2) == rpn("2 0.5 ^")
    true = :math.log(2.7) == rpn("2.7 ln")
    true = :math.log10(2.7) == rpn("2.7 log10")
    50 = rpn("10 10 10 20 sum")
    10.0 = rpn("10 10 10 20 sum 5 /")
    1000.0 = rpn("10 10 20 0.5 prod")
    :ok
  end
end

Calc.rpn("3 5 +")     # => 8
Calc.rpn("7 3 + 5 +") # => 15
Calc.rpn_test         # => :ok
Calc.rpn("1 2 ^ 2 2 ^ 3 2 ^ 4 2 ^ sum 2 -") # => 28.0
