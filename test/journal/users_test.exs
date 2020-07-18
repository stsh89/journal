defmodule Journal.UsersTest do
  use Journal.DataCase

  alias Journal.Users

  describe "users" do
    alias Journal.Users.User

    @valid_attrs %{name: "some name", nickname: "some nickname", password_hash: "some password_hash", password_salt: "some password_salt", slug: "some slug"}
    @invalid_attrs %{name: nil, nickname: nil, password_hash: nil, password_salt: nil, slug: nil}

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
      assert user.nickname == "some nickname"
      assert user.password_hash == "some password_hash"
      assert user.password_salt == "some password_salt"
      assert user.slug == "some slug"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
    end
  end
end
