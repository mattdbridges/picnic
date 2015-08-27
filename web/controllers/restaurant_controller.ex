defmodule Picnic.RestaurantController do
  use Picnic.Web, :controller

  alias Picnic.Restaurant

  plug :scrub_params, "restaurants" when action in [:create, :update]

  def index(conn, _params) do
    restaurants = Repo.all(Restaurant)
    render(conn, "index.html", restaurants: restaurants)
  end

  def new(conn, _params) do
    changeset = Restaurant.changeset(%Restaurant{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"restaurants" => restaurants_params}) do
    changeset = Restaurant.changeset(%Restaurant{}, restaurants_params)

    case Repo.insert(changeset) do
      {:ok, _restaurants} ->
        conn
        |> put_flash(:info, "Restaurant created successfully.")
        |> redirect(to: restaurant_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    restaurants = Repo.get!(Restaurant, id)
    render(conn, "show.html", restaurants: restaurants)
  end

  def edit(conn, %{"id" => id}) do
    restaurants = Repo.get!(Restaurant, id)
    changeset = Restaurant.changeset(restaurants)
    render(conn, "edit.html", restaurants: restaurants, changeset: changeset)
  end

  def update(conn, %{"id" => id, "restaurants" => restaurants_params}) do
    restaurants = Repo.get!(Restaurant, id)
    changeset = Restaurant.changeset(restaurants, restaurants_params)

    case Repo.update(changeset) do
      {:ok, restaurants} ->
        conn
        |> put_flash(:info, "Restaurant updated successfully.")
        |> redirect(to: restaurant_path(conn, :show, restaurants))
      {:error, changeset} ->
        render(conn, "edit.html", restaurants: restaurants, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    restaurants = Repo.get!(Restaurant, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(restaurants)

    conn
    |> put_flash(:info, "Restaurant deleted successfully.")
    |> redirect(to: restaurant_path(conn, :index))
  end
end
