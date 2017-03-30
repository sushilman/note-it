defmodule NoteItWeb.LoginController do
  use NoteItWeb.Web, :controller

  def index(conn, _params) do
    render conn, "login.html"
  end

  def login(conn, %{"login" => %{"email" => email, "password" => password}}) do
    case NoteIt.User.login(email, password) do
      true ->
        expiration_time = 60;
        conn
        |> Plug.Conn.put_resp_cookie("email", email, max_age: expiration_time)
        |> redirect(to: "/")
      :error ->
        conn
        |> put_flash(:error, "Incorrect email or password")
        |> render("login.html")
    end
  end
end
