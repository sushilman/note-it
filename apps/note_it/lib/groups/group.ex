defmodule NoteIt.Group do
  use Ecto.Schema
  import Ecto.Changeset
  alias NoteIt.{User, Note}

  schema "groups" do
    field :name, :string
    belongs_to :owner, User
    has_many :notes, Note
    many_to_many :users, User, join_through: "groups_users"

    timestamps()
  end

  @required_fields [:name]

  def changeset(group, owner \\ nil, users \\ [], params \\ %{}) do
    group_members = Enum.uniq([owner | users])
    group
    |> cast(params, @required_fields)
    |> put_assoc(:owner, owner)
    |> put_assoc(:users, group_members)
    |> validate_required(@required_fields)
    |> unique_constraint(:name)
  end
end
