defmodule NoteItWeb.Router do
  use NoteItWeb.Web, :router

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

  scope "/", NoteItWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/signup", SignupController, :index
    post "/signup", SignupController, :signup
    
    get "/login", LoginController, :index
    post "/login", LoginController, :login
  end

  # Other scopes may use custom stacks.
  # scope "/api", NoteItWeb do
  #   pipe_through :api
  # end
end
