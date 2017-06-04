defmodule FizzBuzz.Web.ItemChannel do
  use FizzBuzz.Web, :channel
  alias FizzBuzz.FizzContext.Item

  def join("item:*", _payload, socket) do
    {:ok, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  def handle_in("toggle_favorite", %{"id" => id}, socket) do
    toggled =
      case :ets.lookup(:db, id) do
        [{_, item}] ->
          %Item{item | favorited: !item.favorited}
        [] ->
          value = FizzBuzz.fizzbuzz(id+1)
          %Item{id: id, value: value, favorited: true}
      end

    :ets.insert(:db, {id, toggled})

    {:reply, {:ok, toggled}, socket}
  end
end
