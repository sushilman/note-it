defmodule NoteIt.Repo.Migrations.CreateGroupsUsersTable do
  use Ecto.Migration

  def change do
    create table(:groups_users) do
      add :user_id, references(:users)
      add :group_id, references(:groups)
    end
  end
end
