defmodule Journal.Repo.Migrations.CreateNotes do
  use Ecto.Migration

  def change do
    create table(:notes) do
      add :name, :string, null: false, default: ""
      add :description, :text, null: false, default: ""

      timestamps()
    end

  end
end
