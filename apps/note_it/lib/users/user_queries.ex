defmodule NoteIt.UserQueries do
  import Ecto.Query
  alias NoteIt.{Repo, User}

  def create(user) do
    Repo.insert(user)
  end

  # def get_all() do
  #   Repo.all(from User)
  # end

  def get_by_id(id) do
    Repo.get(User, id)
    |> Repo.preload([{:groups, [:users]}])
  end

  def get_by_email(email) do
    query = from u in User,
      where: u.email == ^email

    Repo.one(query)
  end

  # def update(user) do
  #   Repo.update(user)
  # end
  #

  def change_password(user, old_password) do
    cond do
      Comeonin.Bcrypt.checkpw(old_password, user.password) ->
        {:ok, Repo.update(user)}
      true ->
        {:error, "Incorrect password!"}
    end
  end
end
