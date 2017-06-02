defmodule FizzBuzz.FizzContext do

  alias FizzBuzz.FizzContext.Item

  def list_items do
    FizzBuzz.perform(100)
    |> Enum.map(&Item.to_struct/1)
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
