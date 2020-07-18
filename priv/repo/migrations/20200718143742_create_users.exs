defmodule Journal.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string, null: false, default: ""
      add :nickname, :string, null: false, default: ""
      add :slug, :string, null: false, default: ""
      add :password_salt, :string, null: false, default: ""
      add :password_hash, :string, null: false, default: ""

      timestamps()
    end

    create unique_index(:users, :slug)
    create unique_index(:users, :nickname)
  end
end
