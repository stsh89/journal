defmodule JournalWeb.SharedNoteController do
  use JournalWeb, :controller

  def show(conn, _params) do
    render(conn, "show.html")
  end
end
