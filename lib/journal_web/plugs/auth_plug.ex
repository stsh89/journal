defmodule JournalWeb.Plugs.AuthPlug do
  alias Plug.Conn
  alias Phoenix.Controller
  alias JournalWeb.Router.Helpers, as: Routes
  alias JournalWeb.Guardian

  def init(_), do: nil

  def call(conn, _) do
    case Guardian.resource_from_token(Conn.get_session(conn, :token)) do
      {:ok, _resource, _claims} ->
        conn
      _ ->
        conn
        |> Conn.delete_session(:token)
        |> Controller.redirect(to: Routes.session_path(conn, :new))
        |> Conn.halt()
    end
  end
end
