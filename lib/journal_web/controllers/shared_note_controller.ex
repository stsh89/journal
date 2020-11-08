defmodule JournalWeb.SharedNoteController do
  use JournalWeb, :controller

  alias Journal.Notebooks
  alias Journal.Repo

  def show(conn, %{"sharing_code" => sharing_code}) do
    note = Notebooks.get_shared_note!(sharing_code)
    render(conn, "show.html", note: note)
  end

  def create(conn, %{"note_id" => id}) do
    note = Notebooks.get_note!(id)
    length = 6
    sharing_code = :crypto.strong_rand_bytes(length) |> Base.url_encode64 |> binary_part(0, length)
    note = Ecto.Changeset.change note, sharing_code: sharing_code

    case Repo.update note do
      {:ok, note}       ->
        conn |> redirect(to: Routes.note_path(conn, :show, note))

      {:error, note} ->
        conn |> redirect(to: Routes.note_path(conn, :show, note))
    end
  end

  def delete(conn, %{"id" => id}) do
    note = Notebooks.get_note!(id)
    note = Ecto.Changeset.change note, sharing_code: nil

    case Repo.update note do
      {:ok, note}       ->
        conn |> redirect(to: Routes.note_path(conn, :show, note))

      {:error, note} ->
        conn |> redirect(to: Routes.note_path(conn, :show, note))
    end
  end
end
