defmodule FizzBuzz.Web.PageControllerTest do
  use FizzBuzz.Web.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Fizz"
  end
end
