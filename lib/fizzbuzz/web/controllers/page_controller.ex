defmodule FizzBuzz.Web.PageController do
  use FizzBuzz.Web, :controller

  @page_size 100
  @total_entries 100_000_000_000
  @total_pages div(@total_entries, @page_size)

  def index(conn, params) do
    page = page_number(params)
    offset = (page - 1) * @page_size
    limit = @page_size + offset - 1
    sequence = Enum.map(offset..limit, &fetch_or_generate_fizzbuzz_item/1)
    scrivener_page = %Scrivener.Page{
      entries: sequence,
      page_number: page,
      page_size: @page_size,
      total_entries: @total_entries,
      total_pages: @total_pages
    }

    case content_type(params) do
      :json -> json conn, sequence
      :html -> render conn, "index.html", page: scrivener_page
    end
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

  defp content_type(%{"json" => _}), do: :json
  defp content_type(_params), do: :html
end
