defmodule FizzBuzz do

  @doc """
  Returns a list of the first N Fizz Buzz words.

  ## Example

  iex> FizzBuzz.perform(10)
  ["1", "2", "Fizz", "4", "Buzz", "Fizz", "7", "8", "Fizz", "Buzz"]
  """
  @spec perform(integer) :: [String.t]
  def perform(n), do: Enum.map(1..n, &fizzbuzz/1)

  @doc """
  Returns the FizzBuzz value of a number.

  ## Examples

  iex> FizzBuzz.fizzbuzz(3)
  "Fizz"

  iex> FizzBuzz.fizzbuzz(5)
  "Buzz"
  """
  @spec fizzbuzz(integer) :: String.t
  def fizzbuzz(i) do
    cond do
      rem(i, 3) == 0 && rem(i, 5) == 0 -> "FizzBuzz"
      rem(i, 3) == 0 -> "Fizz"
      rem(i, 5) == 0 -> "Buzz"
      true -> to_string i
    end
  end
end
