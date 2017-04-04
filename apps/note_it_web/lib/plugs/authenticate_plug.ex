defmodule NoteItWeb.Plugs.AuthenticatePlug do
  import Plug.Conn
  import Phoenix.Controller

  def init(opts) do
    opts
  end

  def call(conn, id) do
    authenticate_user(conn)
  end

  defp authenticate_user(conn) do
    cond do
      get_session(conn, :current_userid) == nil ->
        conn
        |> redirect(to: "/login")
        |> halt
      true ->
        conn
    end

  end
end
