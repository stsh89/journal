defmodule Journal.UsersTest do
  use Journal.DataCase

  alias Journal.Users

  describe "users" do
    alias Journal.Users.User

    @valid_attrs %{name: "some name", password_hash: "some password_hash", slug: "some slug"}
    @invalid_attrs %{name: nil, password_hash: nil, slug: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Users.create_user()

      user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Users.create_user(@valid_attrs)
      assert user.name == "some name"
      assert user.password_hash == "some password_hash"
      assert user.slug == "some slug"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
    end
  end
end
