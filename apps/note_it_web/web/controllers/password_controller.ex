defmodule NoteItWeb.PasswordController do
  use NoteItWeb.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def change(conn, %{"change_password" => params}) do
    user = NoteItWeb.Session.current_user(conn)
    IO.inspect user
    cond do
      params["new_password"] == "" ->
        conn
        |> put_flash(:error, "Empty password is not accepted.")
        |> redirect(to: password_path(conn, :index))

      params["new_password"] == params["confirm_password"] ->
        conn
        |> put_flash(:info, "Password Changed!")
        |> redirect(to: "/")

      true ->
        conn
        |> put_flash(:error, "'New Password' does not match the 'Confirm New Password'.")
        |> redirect(to: password_path(conn, :index))
    end
  end
end
