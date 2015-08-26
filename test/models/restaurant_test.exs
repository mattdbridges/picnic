defmodule Picnic.RestaurantTest do
  use Picnic.ModelCase

  alias Picnic.Restaurant

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{name: "s"}

  test "changeset with valid attributes" do
    changeset = Restaurant.changeset(%Restaurant{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Restaurant.changeset(%Restaurant{}, @invalid_attrs)
    refute changeset.valid?
  end
end
