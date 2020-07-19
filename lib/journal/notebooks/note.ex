defmodule Journal.Notebooks.Note do
  use Ecto.Schema
  import Ecto.Changeset

  schema "notes" do
    field :description, :string
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(note, attrs) do
    note
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
