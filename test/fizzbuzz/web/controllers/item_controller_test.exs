defmodule FizzBuzz.Web.ItemControllerTest do
  use FizzBuzz.Web.ConnCase

  alias FizzBuzz.FizzContext

  @create_attrs %{favorited: true, value: "some value"}
  @update_attrs %{favorited: false, value: "some updated value"}
  @invalid_attrs %{favorited: nil, value: nil}

  def fixture(:item) do
    {:ok, item} = FizzContext.create_item(@create_attrs)
    item
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, item_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Items"
  end

  test "renders form for new items", %{conn: conn} do
    conn = get conn, item_path(conn, :new)
    assert html_response(conn, 200) =~ "New Item"
  end

  test "creates item and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, item_path(conn, :create), item: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == item_path(conn, :show, id)

    conn = get conn, item_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Item"
  end

  test "does not create item and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, item_path(conn, :create), item: @invalid_attrs
    assert html_response(conn, 200) =~ "New Item"
  end

  test "renders form for editing chosen item", %{conn: conn} do
    item = fixture(:item)
    conn = get conn, item_path(conn, :edit, item)
    assert html_response(conn, 200) =~ "Edit Item"
  end

  test "updates chosen item and redirects when data is valid", %{conn: conn} do
    item = fixture(:item)
    conn = put conn, item_path(conn, :update, item), item: @update_attrs
    assert redirected_to(conn) == item_path(conn, :show, item)

    conn = get conn, item_path(conn, :show, item)
    assert html_response(conn, 200) =~ "some updated value"
  end

  test "does not update chosen item and renders errors when data is invalid", %{conn: conn} do
    item = fixture(:item)
    conn = put conn, item_path(conn, :update, item), item: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Item"
  end

  test "deletes chosen item", %{conn: conn} do
    item = fixture(:item)
    conn = delete conn, item_path(conn, :delete, item)
    assert redirected_to(conn) == item_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, item_path(conn, :show, item)
    end
  end
end
