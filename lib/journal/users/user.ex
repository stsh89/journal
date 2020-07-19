defmodule Journal.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :password_hash, :string
    field :slug, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def registration_changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :slug, :password_hash])
    |> validate_required([:name, :slug, :password_hash])
    |> unique_constraint(:slug)
  end
end
