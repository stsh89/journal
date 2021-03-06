defmodule JournalWeb.SessionController do
  use JournalWeb, :controller

  alias JournalWeb.Sessions
  alias JournalWeb.Sessions.Session

  def new(conn, _params) do
    if conn |> get_session(:token) do
      conn
      |> redirect(to: "/")
      |> halt()
    end

    changeset = Sessions.change_session(%Session{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"session" => session_params}) do
    case Sessions.create_session(session_params) do
      {:ok, session} ->
        conn
        |> put_session(:token, session.token)
        |> put_flash(:info, "Session created successfully.")
        |> redirect(to: Routes.note_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:token)
    |> redirect(to: Routes.session_path(conn, :new))
  end
end
