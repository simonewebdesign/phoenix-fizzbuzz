defmodule FizzBuzz.Web.PageController do
  use FizzBuzz.Web, :controller

  def index(conn, _params) do
    render conn, "index.html", fizzbuzz_sequence: FizzBuzz.perform(100)
  end
end
