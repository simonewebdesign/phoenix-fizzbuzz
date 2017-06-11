defmodule FizzBuzz.Web.ItemChannelTest do
  use FizzBuzz.Web.ChannelCase

  alias FizzBuzz.Web.ItemChannel

  setup do
    {:ok, _, socket} =
      socket("user_id", %{})
      |> subscribe_and_join(ItemChannel, "item:*")

    {:ok, socket: socket}
  end

  test "ping replies with status ok", %{socket: socket} do
    ref = push socket, "ping", %{"hello" => "there"}
    assert_reply ref, :ok, %{"hello" => "there"}
  end

  test "marking items as favorites", %{socket: socket} do
    ref = push socket, "toggle_favorite", %{"id" => 123}
    assert_reply ref, :ok, %FizzBuzz.Item{favorited: true, id: 123, value: "124"}
  end
end
