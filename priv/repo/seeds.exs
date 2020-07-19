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

alias Journal.Users.User
alias Journal.{Users, Repo}

if Repo.aggregate(User, :count, :id) == 0 do
  %{password_hash: password_hash} = Bcrypt.add_hash("password")

  Users.create_user(%{
    name: "Stan",
    password_hash: password_hash,
    slug: "stan"
  })
end

