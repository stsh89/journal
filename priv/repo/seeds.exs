# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Journal.Repo.insert!(%Journal.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Journal.Accounts.Credential
alias Journal.{Accounts, Repo}

if Repo.aggregate(Credential, :count, :id) == 0 do
  Accounts.create_credential(%{
    login: "Stan",
    password_hash: Bcrypt.add_hash("password") |> Map.get(:password_hash)
  })
end

