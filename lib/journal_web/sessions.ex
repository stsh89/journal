defmodule JournalWeb.Sessions do
  import Ecto.Query, warn: false

  alias Ecto.Changeset
  alias JournalWeb.Sessions.Session

  def create_session(attrs \\ %{}) do
    %Session{}
    |> Session.changeset(attrs)
    |> Changeset.apply_action(:insert)
  end

  def change_session(%Session{} = session, attrs \\ %{}) do
    Session.changeset(session, attrs)
  end
end
