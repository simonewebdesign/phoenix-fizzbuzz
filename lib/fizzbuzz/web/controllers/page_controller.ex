defmodule FizzBuzz.Web.PageController do
  use FizzBuzz.Web, :controller

  def index(conn, _params) do
    limit = 100
    sequence = Enum.map(0..limit, &fetch_or_generate_fizzbuzz_item/1)
    render conn, "index.html", fizzbuzz_sequence: sequence
  end

  defp fetch_or_generate_fizzbuzz_item(id) do
    case :ets.lookup(:db, id) do
      [{_, item}] -> item
      [] -> FizzBuzz.FizzContext.Item.to_struct(id, FizzBuzz.fizzbuzz(id+1))
    end
  end
end
