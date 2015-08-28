defmodule Picnic.API.RestaurantView do
  use Picnic.Web, :view

  def render("index.json", %{restaurants: restaurants}) do
    %{data: render_many(restaurants, Picnic.API.RestaurantView, "restaurant.json")}
  end

  def render("show.json", %{restaurant: restaurant}) do
    %{data: render_one(restaurant, Picnic.API.RestaurantView, "restaurant.json")}
  end

  def render("restaurant.json", %{restaurant: restaurant}) do
    %{id: restaurant.id,
      name: restaurant.name}
  end
end
