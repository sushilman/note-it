defmodule UserTest do
  use ExUnit.Case
  import NoteIt.User

  setup do
    password = "dummyPassword"
    user = %NoteIt.User{}
    params = %{email: "dummyemail@example.com",
               password: password,
               name: "dummy"
              }
    [password: password, user: user, params: params]
  end

  test "invalid changeset, if email is not provided", context do
    change_set = changeset(context.user, %{context.params | email: nil})
    assert change_set.valid? == false
  end

  # simply testing that the password is modified and not stored as it is
  test "changeset hashes password", context do
    changeset_password = context.user
                      |> changeset(context.params)
                      |> Ecto.Changeset.get_change(:password)

    assert changeset_password != context.password
  end
end
