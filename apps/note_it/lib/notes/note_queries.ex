defmodule NoteIt.NoteQueries do
  import Ecto.Query
  alias NoteIt.{Repo, Note}


  def get_by_id(id) do
    Repo.get(NoteIt, id)
  end
end
