defmodule Journal.NotebooksTest do
  use Journal.DataCase

  alias Journal.Notebooks

  describe "notes" do
    alias Journal.Notebooks.Note

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    def note_fixture(attrs \\ %{}) do
      {:ok, note} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Notebooks.create_note()

      note
    end

    test "list_notes/0 returns all notes" do
      note = note_fixture()
      assert Notebooks.list_notes() == [note]
    end

    test "get_note!/1 returns the note with given id" do
      note = note_fixture()
      assert Notebooks.get_note!(note.id) == note
    end

    test "create_note/1 with valid data creates a note" do
      assert {:ok, %Note{} = note} = Notebooks.create_note(@valid_attrs)
      assert note.description == "some description"
      assert note.name == "some name"
    end

    test "create_note/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Notebooks.create_note(@invalid_attrs)
    end

    test "update_note/2 with valid data updates the note" do
      note = note_fixture()
      assert {:ok, %Note{} = note} = Notebooks.update_note(note, @update_attrs)
      assert note.description == "some updated description"
      assert note.name == "some updated name"
    end

    test "update_note/2 with invalid data returns error changeset" do
      note = note_fixture()
      assert {:error, %Ecto.Changeset{}} = Notebooks.update_note(note, @invalid_attrs)
      assert note == Notebooks.get_note!(note.id)
    end

    test "delete_note/1 deletes the note" do
      note = note_fixture()
      assert {:ok, %Note{}} = Notebooks.delete_note(note)
      assert_raise Ecto.NoResultsError, fn -> Notebooks.get_note!(note.id) end
    end

    test "change_note/1 returns a note changeset" do
      note = note_fixture()
      assert %Ecto.Changeset{} = Notebooks.change_note(note)
    end
  end
end
