defmodule FizzBuzz.Web.PageController do
  use FizzBuzz.Web, :controller

  @page_size 100
  @total_entries 100_000_000_000
  @total_pages div(@total_entries, @page_size)

  def index(conn, params) do
    page = from_params(params, "page", 1)
    page_size = from_params(params, "page_size", @page_size)
    offset = (page - 1) * page_size
    limit = page_size + offset - 1
    sequence = Enum.map(offset..limit, &fetch_or_generate_fizzbuzz_item/1)
    scrivener_page = %Scrivener.Page{
      entries: sequence,
      page_number: page,
      page_size: page_size,
      total_entries: @total_entries,
      total_pages: @total_pages
    }
    case content_type(params) do
      :json -> json conn, sequence
      :html -> render conn, "index.html", page: scrivener_page
    end
  end


  defp from_params(params, name, default) do
    %{^name => value} = params

    case Integer.parse value do
      {int, _rem} -> if int > 0, do: int, else: default
      :error -> default
    end

  rescue
    MatchError -> default
  end


  defp fetch_or_generate_fizzbuzz_item(id) do
    case :ets.lookup(:db, id) do
      [{_, item}] -> item
      [] -> FizzBuzz.Item.to_struct(id, FizzBuzz.fizzbuzz(id+1))
    end
  end


  defp content_type(%{"json" => _}), do: :json
  defp content_type(_params), do: :html
end
