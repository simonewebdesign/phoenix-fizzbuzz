defmodule FizzBuzz.FizzContext.Item do
  @moduledoc """
  The model for a FizzBuzz item.
  """

  defstruct id: 0, value: "default", favorited: false

  @doc """
  Creates a new struct, starting from a value such as
  "1", "Fizz", "Buzz", or "FizzBuzz".

  Items are not favorited by default.

  ## Examples
  iex> FizzBuzz.FizzContext.Item.to_struct(123, "Fizz")
  %FizzBuzz.FizzContext.Item{
    id: 123,
    value: "Fizz",
    favorited: false
  }
  """
  @spec to_struct(integer, String.t) :: %__MODULE__{}
  def to_struct(id, value), do:
    %__MODULE__{
      id: id,
      value: value,
      favorited: false
    }
end
