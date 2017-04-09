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
    case NoteIt.GroupQueries.create(changeset) do
      {:ok, _} ->
        conn
        |> redirect(to: group_path(conn, :list))
      {:error, errors} ->
        conn
        |> put_flash(:error, "Group with the same name already exists.")
        |> render("create.html", changeset: errors)
    end
  end

  def details(conn, %{"name" => group_name}) do
    group = NoteIt.GroupQueries.get_by_name(group_name)
    render conn, "details.html", group: group
  end

  def invite(conn, %{"name" => group_name}) do
    render conn, "invite.html", group_name: group_name
  end

  def add_member(conn, %{"member" => member, "name" => group_name}) do
    # add to group
    owner = NoteItWeb.Session.current_user(conn)
    group = NoteIt.GroupQueries.get_by_name(group_name)
    invited_user = NoteIt.UserQueries.get_by_email(member["email"])

    if invited_user != owner do
      changeset = NoteIt.Group.changeset(group, owner, [invited_user | group.users])      
      NoteIt.GroupQueries.update(changeset)
    end

    conn
    |> redirect(to: group_path(conn, :invite, group_name))
  end
end
