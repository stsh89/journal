defmodule Journal.Accounts.Credential do
  use Ecto.Schema
  import Ecto.Changeset

  schema "credentials" do
    field :login, :string
    field :password_hash, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(credential, attrs) do
    credential
    |> cast(attrs, [:login, :password_hash])
    |> validate_required([:login, :password_hash])
    |> unique_constraint(:login)
  end
end
