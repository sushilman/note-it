defmodule NoteIt.GroupQueries do
  import Ecto.Query
  alias NoteIt.{Repo, Group}

  def create(group) do
    Repo.insert(group)
  end

  def get_by_id(id) do
    Repo.get(Group, id)
    |> Repo.preload(:owner)
    |> Repo.preload(:users)
  end

  def get_by_name(name) do
    query = from g in Group,
            where: g.name == ^name
    Repo.one(query)
    |> Repo.preload(:owner)
    |> Repo.preload(:users)

  end

  def update(group) do
    # dis-allow changing owner
    Repo.update(group)
  end

  def delete(group) do
    # only the owner may delete
    Repo.delete(group)
  end
end
