defmodule JournalWeb.Sessions.Session do
  defstruct login: nil, password: nil

  import Ecto.Changeset

  def changeset(session, attrs) do
    {session, %{login: :string, password: :string}}
    |> cast(attrs, [:login, :password])
    |> validate_required([:login, :password])
  end
end
