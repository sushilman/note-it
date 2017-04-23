defmodule NoteItWeb.NoteController do
  use NoteItWeb.Web, :controller

  def list(conn, _params) do
    user = NoteItWeb.Session.current_user(conn)

    notes = NoteIt.NoteQueries.get_by_user(user)
    render conn, "list.html", notes: notes
  end

  def show(conn, %{"id" => id}) do
    user = NoteItWeb.Session.current_user(conn)
    note = NoteIt.NoteQueries.get_by_id(id)

    has_access = user.groups
                  |> Enum.reduce([], fn x, acc -> [x.id | acc] end)
                  |> Enum.member?(note.group.id)

    if (has_access) do
        render conn, "edit.html", note: note
    else
      conn
      |> put_flash(:error, "Access denied")
      |> redirect(to: "/")
    end
  end

end
