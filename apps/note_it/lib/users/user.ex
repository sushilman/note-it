defmodule NoteIt.User do
  use Ecto.Schema

  import Ecto.Changeset
  alias NoteIt.Group

  schema "users" do
    field :email, :string
    field :password, :string
    field :name, :string

    has_many :groups_owned, Group, foreign_key: :group_id
    many_to_many :groups, Group, join_through: "groups_users"

    timestamps()
  end

  @required_fields ~w(email password name)a

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, @required_fields)
    |> cast_assoc(:groups_owned)
    |> cast_assoc(:groups)
    |> validate_required(@required_fields)
    |> hash_password()
  end

  defp hash_password(changeset) do
    password = get_change(changeset, :password)

    if password do
      hashed_password = Comeonin.Bcrypt.hashpwsalt(password)
      changeset
      |> put_change(:password, hashed_password)
      #|> delete_change(:confirm_password)
    else
      changeset
    end

  end

end
