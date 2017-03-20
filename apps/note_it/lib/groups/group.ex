defmodule NoteIt.Group do
  use Ecto.Schema

  import Ecto.Changeset

  schema "groups" do
    field :name, :string
    belongs_to :owner, NoteIt.User
    many_to_many :users, NoteIt.User, join_through: "groups_users"

    timestamps()
  end

  @required_fields [:name]


  def changeset(group, params \\ %{}) do
    group
    |> cast(params, @required_fields)
    |> cast_assoc(:owner)
    |> cast_assoc(:users)
  end
end
