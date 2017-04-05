defmodule NoteItWeb.NoteController do
  use NoteItWeb.Web, :controller

  def list(conn, _params) do
    user = NoteItWeb.Session.current_user(conn)

    notes = NoteIt.NoteQueries.get_all_for_groups(user.groups)
    render conn, "list.html", notes: notes
  end

  def show(conn, %{"id" => id}) do
    note = NoteIt.NoteQueries.get_by_id(id)

    render conn, "edit.html", note: note
  end

end
