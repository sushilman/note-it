defmodule NoteIt.Repo.Migrations.AddNotesTable do
  use Ecto.Migration

  def change do
    create table(:notes) do
      add :title, :string, size: 100
      add :note, :string
      add :group_id, references(:groups)

      timestamps()
    end
  end
end
