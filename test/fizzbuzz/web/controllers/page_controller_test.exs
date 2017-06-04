defmodule FizzBuzz.Web.PageControllerTest do
  use FizzBuzz.Web.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Fizz"
  end

  test "GET /?json", %{conn: conn} do
    conn = get conn, "/?json"
    assert hd(json_response(conn, 200)) ==
      %{"id" => 0, "value" => "1", "favorited" => false}
  end
end
