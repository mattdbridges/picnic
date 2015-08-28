defmodule Picnic.Router do
  use Picnic.Web, :router

  pipeline :browser do
    plug :accepts, ~w(html)
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ~w(json)
  end

  scope "/", Picnic do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    resources "/restaurants", RestaurantController
  end

  scope "/api", Picnic, as: "api" do
    pipe_through :api

    resources "/restaurants", API.RestaurantController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Picnic do
  #   pipe_through :api
  # end
end
