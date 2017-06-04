defmodule FizzBuzz.Web.PageController do
  use FizzBuzz.Web, :controller

  @page_size 100

  def index(conn, params) do
    page = page_number(params)
    offset = (page - 1) * @page_size
    limit = @page_size + offset - 1
    sequence = Enum.map(offset..limit, &fetch_or_generate_fizzbuzz_item/1)
    render conn, "index.html", fizzbuzz_sequence: sequence
  end

  defp page_number(%{"page" => p}) do
    case Integer.parse p do
      {int, _rem} -> if int > 0, do: int, else: 1
      :error -> 1
    end
  end
  defp page_number(_params), do: 1

  defp fetch_or_generate_fizzbuzz_item(id) do
    case :ets.lookup(:db, id) do
      [{_, item}] -> item
      [] -> FizzBuzz.FizzContext.Item.to_struct(id, FizzBuzz.fizzbuzz(id+1))
    end
  end
end
