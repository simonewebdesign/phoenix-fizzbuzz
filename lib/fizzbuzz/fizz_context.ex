defmodule FizzBuzz.FizzContext do

  alias FizzBuzz.FizzContext.Item

  def list_items do
    FizzBuzz.perform(100)
    |> Stream.with_index()
    |> Stream.map(fn {value, index} -> Item.to_struct(index, value) end)
    |> Enum.to_list()
  end

  def change_item(%FizzBuzz.FizzContext.Item{} = item) do
  end

  def create_item(item_params) do
  end

  def get_item!(id) do
  end

  def change_item(item) do
  end

  def update_item(item, item_params) do
  end

  def delete_item(item) do
  end
end
