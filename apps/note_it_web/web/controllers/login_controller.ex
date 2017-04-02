defmodule NoteItWeb.LoginController do
  use NoteItWeb.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def login(conn, %{"login" => %{"email" => email, "password" => password}}) do
    case NoteItWeb.Login.login(email, password) do
      {:ok, user} ->
        conn
        |> put_session(:current_userid, user.id)
        #|> Plug.Conn.put_resp_cookie("email", email, max_age: 60)
        |> redirect(to: "/")
      :error ->
        conn
        |> put_flash(:error, "Incorrect email or password")
        |> render("index.html")
    end
  end

  def logout(conn, _params) do
    conn
    |> delete_session(:current_userid)
    |> put_flash(:info, "Logged Out")
    |> redirect(to: "/")
  end
end
