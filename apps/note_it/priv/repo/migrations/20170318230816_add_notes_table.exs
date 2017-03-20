defmodule NoteIt.Repo.Migrations.AddNotesTable do
  use Ecto.Migration

  def change do
    create table(:notes) do
      add :title, :string, size: 100
      add :note, :string

      timestamps()
    end
  end
end
