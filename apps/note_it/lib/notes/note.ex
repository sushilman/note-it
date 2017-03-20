defmodule NoteIt.Note do
  use Ecto.Schema

  import Ecto.Changeset

  schema "notes" do
    field :title, :string
    field :note, :string
    belongs_to :group, NoteIt.Group

    timestamps()
  end

  @required_fields [:title]
  @optional_fields [:note]

  def changeset(note, params \\ %{}) do
    note
    |> cast(params, @required_fields ++ @optional_fields)
    |> cast_assoc(:group)
  end
end
