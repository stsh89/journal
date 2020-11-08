defmodule JournalWeb.NoteView do
  use JournalWeb, :view

  alias Journal.Notebooks.Note

  def shared_note_icon(%Note{sharing_code: nil}), do: "☐"
  def shared_note_icon(%Note{}), do: "☑"

  def shared_note?(%Note{sharing_code: nil}), do: false
  def shared_note?(%Note{}), do: true
end
