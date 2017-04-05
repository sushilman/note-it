defmodule NoteItWeb.GroupController do
  use NoteItWeb.Web, :controller

  def list(conn, _params) do
    user = NoteItWeb.Session.current_user(conn)
    render conn, "list.html", groups: user.groups
  end
end
