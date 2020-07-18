defmodule Journal.Users do
  import Ecto.Query, warn: false

  alias Journal.Repo
  alias Journal.Users.User

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end
end
