defmodule Journal.Repo.Migrations.CreateCredentials do
  use Ecto.Migration

  def change do
    create table(:credentials) do
      add :login, :string, null: false, default: ""
      add :password_hash, :string, null: false, default: ""

      timestamps()
    end

    create unique_index(:credentials, :login)
  end
end
