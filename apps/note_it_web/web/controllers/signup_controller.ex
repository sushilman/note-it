defmodule NoteItWeb.SignupController do
  use NoteItWeb.Web, :controller

  def index(conn, %{errors: errors}) do
    render(conn, "index.html", changeset: errors)
  end

  def index(conn, _params) do
    changeset = NoteIt.User.changeset(%NoteIt.User{})
    render conn, "index.html", changeset: changeset
  end

  def signup(conn, %{"signup" => user_params}) do
    changeset = NoteIt.User.changeset(%NoteIt.User{}, user_params)

    case NoteIt.UserQueries.create(changeset) do
      {:ok, %{id: id}} ->
        conn
        |> put_session(:current_userid, id)
        |> redirect(to: "/")
      {:error, reasons} ->
        index(conn, %{errors: reasons})
    end
  end
end
