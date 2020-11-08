defmodule Journal.Repo.Migrations.AddSharingCodeToNotes do
  use Ecto.Migration

  def change do
    alter table(:notes) do
      add :sharing_code, :string
    end

    create unique_index(:notes, :sharing_code)
  end
end
