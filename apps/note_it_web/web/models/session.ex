defmodule NoteItWeb.Session do
  def login(email, password) do
    user = NoteIt.UserQueries.get_by_email(email)
    do_login(password, user)
  end

  defp do_login(password, nil), do:  :error
  defp do_login(password, user) do
    cond do
      authenticate(password, user.password) -> {:ok, user}
      true -> :error
    end
  end

  defp authenticate(nil, _), do: false
  defp authenticate(password, hashed_password) do
    Comeonin.Bcrypt.checkpw(password, hashed_password)
  end

  def current_user(conn) do
    id = Plug.Conn.get_session(conn, :current_userid)
    if id, do: NoteIt.UserQueries.get_by_id(id)
  end

  def logged_in?(conn), do: !!current_user(conn) #double negation to cast to boolean from truthy/falsy value
end
