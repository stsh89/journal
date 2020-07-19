defmodule Journal.Accounts do
  import Ecto.Query, warn: false

  alias Journal.Repo
  alias Journal.Accounts.Credential

  def create_credential(attrs \\ %{}) do
    %Credential{}
    |> Credential.changeset(attrs)
    |> Repo.insert()
  end
end
