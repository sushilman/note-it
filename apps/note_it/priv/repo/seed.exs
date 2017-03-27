{:ok, user} = NoteIt.UserQueries.create(NoteIt.User.changeset(%NoteIt.User{}, %{name: "Sushil", email: "sushilman@gmail.com", password: "secret"}))
{:ok, group} = NoteIt.GroupQueries.create(NoteIt.Group.changeset(%NoteIt.Group{}, user, [], %{name: "MyGroup"}))
NoteIt.NoteQueries.create(NoteIt.Note.changeset(%NoteIt.Note{}, group, %{title: "My note", note: "something long goes here"}))
