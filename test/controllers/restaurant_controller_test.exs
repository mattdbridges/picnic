defmodule Picnic.RestaurantControllerTest do
  use Picnic.ConnCase

  alias Picnic.Restaurant
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, restaurant_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing restaurants"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, restaurant_path(conn, :new)
    assert html_response(conn, 200) =~ "New restaurants"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, restaurant_path(conn, :create), restaurants: @valid_attrs
    assert redirected_to(conn) == restaurant_path(conn, :index)
    assert Repo.get_by(Restaurant, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, restaurant_path(conn, :create), restaurants: @invalid_attrs
    assert html_response(conn, 200) =~ "New restaurants"
  end

  test "shows chosen resource", %{conn: conn} do
    restaurants = Repo.insert! %Restaurant{}
    conn = get conn, restaurant_path(conn, :show, restaurants)
    assert html_response(conn, 200) =~ "Show restaurants"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, restaurant_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    restaurants = Repo.insert! %Restaurant{}
    conn = get conn, restaurant_path(conn, :edit, restaurants)
    assert html_response(conn, 200) =~ "Edit restaurants"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    restaurants = Repo.insert! %Restaurant{}
    conn = put conn, restaurant_path(conn, :update, restaurants), restaurants: @valid_attrs
    assert redirected_to(conn) == restaurant_path(conn, :show, restaurants)
    assert Repo.get_by(Restaurant, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    restaurants = Repo.insert! %Restaurant{}
    conn = put conn, restaurant_path(conn, :update, restaurants), restaurants: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit restaurants"
  end

  test "deletes chosen resource", %{conn: conn} do
    restaurants = Repo.insert! %Restaurant{}
    conn = delete conn, restaurant_path(conn, :delete, restaurants)
    assert redirected_to(conn) == restaurant_path(conn, :index)
    refute Repo.get(Restaurant, restaurants.id)
  end
end
