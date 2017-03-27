defmodule NoteIt.Repo.Migrations.AddGroupsTable do
  use Ecto.Migration

  def change do
    create table(:groups) do
      add :name, :string, size: 50
      add :owner_id, references(:users)

      timestamps()
    end
  end
end
