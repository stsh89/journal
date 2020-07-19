defmodule Journal.AccountsTest do
  use Journal.DataCase

  alias Journal.Accounts

  describe "credentials" do
    alias Journal.Accounts.Credential

    @valid_attrs %{login: "some login", password_hash: "some password hash"}
    @invalid_attrs %{login: nil, password_hash: nil}

    def credential_fixture(attrs \\ %{}) do
      {:ok, credential} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_credential()

      credential
    end

    test "create_credential/1 with valid data creates a credential" do
      assert {:ok, %Credential{} = credential} = Accounts.create_credential(@valid_attrs)
      assert credential.login == "some login"
      assert credential.password_hash == "some password hash"
    end

    test "create_credential/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_credential(@invalid_attrs)
    end
  end
end
