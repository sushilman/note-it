defmodule NoteItWeb.GroupController do
  use NoteItWeb.Web, :controller

  def list(conn, _params) do
    user = NoteItWeb.Session.current_user(conn)
    render conn, "list.html", groups: user.groups
  end

  def create(conn, _params) do
    #owner = NoteItWeb.Session.current_user(conn)
    changeset = NoteIt.Group.changeset(%NoteIt.Group{})
    render conn, "create.html", changeset: changeset
  end

  def add(conn, %{"group" => group}) do
    owner = NoteItWeb.Session.current_user(conn)
    changeset = NoteIt.Group.changeset(%NoteIt.Group{}, owner, [], group)
    NoteIt.GroupQueries.create(changeset);
    conn
    |> redirect(to: group_path(conn, :list))
  end

  def details(conn, %{"id" => group_id}) do
    group = NoteIt.GroupQueries.get_by_id(group_id)
    render conn, "details.html", group: group
  end
end
