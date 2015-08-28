defmodule Picnic.API.RestaurantControllerTest do
  use Picnic.ConnCase

  alias Picnic.Restaurant
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, api_restaurant_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    restaurant = Repo.insert! %Restaurant{}
    conn = conn |> get(api_restaurant_path(conn, :show, restaurant))
    assert json_response(conn, 200)["data"] == %{
      "id" => restaurant.id,
      "name" => restaurant.name
    }
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, api_restaurant_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, api_restaurant_path(conn, :create), restaurant: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Restaurant, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, api_restaurant_path(conn, :create), restaurant: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    restaurant = Repo.insert! %Restaurant{}
    conn = put conn, api_restaurant_path(conn, :update, restaurant), restaurant: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Restaurant, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    restaurant = Repo.insert! %Restaurant{}
    conn = put conn, api_restaurant_path(conn, :update, restaurant), restaurant: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    restaurant = Repo.insert! %Restaurant{}
    conn = delete conn, api_restaurant_path(conn, :delete, restaurant)
    assert response(conn, 204)
    refute Repo.get(Restaurant, restaurant.id)
  end
end
