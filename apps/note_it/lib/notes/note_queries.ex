defmodule NoteIt.NoteQueries do
  import Ecto.Query
  alias NoteIt.{Repo, Note}

  def create(note) do
    Repo.insert(note)
  end

  def get_by_id(id) do
    Repo.get(Note, id)
    |> Repo.preload(:group)
    #|> Repo.preload([{:group, :owner}]) #for nested preloading
  end

  def get_all_by_group(group_id) do
    query = from n in Note,
      where: n.group_id == ^group_id

    Repo.all(query)
  end

  def get_by_user(user) do

  end

  def update(note) do
    Repo.update(note)
  end

  def delete(note) do
    Repo.delete(note)
  end
end
