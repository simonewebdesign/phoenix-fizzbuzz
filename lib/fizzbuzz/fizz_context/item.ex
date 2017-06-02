defmodule FizzBuzz.FizzContext.Item do
  @moduledoc """
  The model for a FizzBuzz item.
  """

  @derive {Phoenix.Param, key: :value}
  defstruct value: "default", favorited: false

  @doc """
  Creates a new struct, starting from a value such as
  "1", "Fizz", "Buzz", or "FizzBuzz".

  Items are not favorited by default.
  """
  @spec to_struct(String.t) :: %__MODULE__{}
  def to_struct(value), do:
    %__MODULE__{
      value: value,
      favorited: false
    }
end
