defmodule NoteIt.User do
  use Ecto.Schema

  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :password, :string
    field :name, :string

    has_many :groups_owned, NoteIt.Group, foreign_key: :group_id
    many_to_many :groups, NoteIt.Group, join_through: "groups_users"

    timestamps()
  end

  @required_fields ~w(email password name)a

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, @required_fields)
    |> cast_assoc(:groups_owned)
    |> cast_assoc(:groups)
    |> validate_required(@required_fields)
  end


end