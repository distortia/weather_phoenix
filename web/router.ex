defmodule WeatherPhoenix.Router do
  use WeatherPhoenix.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WeatherPhoenix do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    post "/weather", PageController, :set_weather
    get "/weather/:location", PageController, :get_weather
  end

  # Other scopes may use custom stacks.
  # scope "/api", WeatherPhoenix do
  #   pipe_through :api
  # end
end
