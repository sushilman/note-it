defmodule NoteItWeb.Router do
  use NoteItWeb.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :authenticate do
    plug NoteItWeb.Plugs.AuthenticatePlug
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

  scope "/", NoteItWeb do
    pipe_through [:browser, :authenticate]

    get "/password", PasswordController, :index
    post "/password", PasswordController, :change

    get "/logout", LoginController, :logout

    get "/groups", GroupController, :list # list groups the user belongs to_
    get "/groups/create", GroupController, :create
    post "/groups/create", GroupController, :add
    get "/groups/g/:name/invite", GroupController, :invite
    post "/groups/g/:name/invite", GroupController, :add_member
    get "/groups/g/:name", GroupController, :details

    get "/notes", NoteController, :list # list notes from all groups the user belongs to
    #get "/notes/create", NoteController, :create
    get "/notes/:id", NoteController, :show
    post "/notes/:id", NoteController, :update
    # get "/notes/:id/delete", NoteController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", NoteItWeb do
  #   pipe_through :api
  # end
end
