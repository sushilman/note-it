defmodule NoteItWeb.SignupController do
  use NoteItWeb.Web, :controller

  def index(conn, _params) do
    changeset = NoteIt.User.changeset(%NoteIt.User{}, %{})
    render conn, "signup.html", changeset: changeset
  end

  def signup(conn, params) do

  end
end
