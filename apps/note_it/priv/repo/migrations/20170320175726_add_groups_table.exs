defmodule NoteIt.Repo.Migrations.AddGroupsTable do
  use Ecto.Migration

  def change do
    create table(:groups) do
      add :name, :string, size: 50
      add :owner, references(:users)
    end
  end
end
