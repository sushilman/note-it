defmodule NoteIt.Repo.Migrations.AddUsersTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, size: 50
      add :password, :string, size: 50
      add :name, :string

      timestamps()
    end
  end
end
