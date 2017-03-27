defmodule NoteIt.Repo.Migrations.UserPasswordFieldLengthIncrease do
  use Ecto.Migration

  def change do
    alter table(:users) do
      modify :password, :string, size: 60
    end
  end
end
