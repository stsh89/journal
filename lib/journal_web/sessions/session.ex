defmodule JournalWeb.Sessions.Session do
  defstruct login: "", password: "", token: ""

  import Ecto.Changeset

  alias Journal.Accounts

  def changeset(session, attrs) do
    {session, %{login: :string, password: :string, token: :string}}
    |> cast(attrs, [:login, :password])
    |> validate_required([:login, :password])
    |> validate_credentials
  end

  defp validate_credentials(changeset) do
    login = get_field(changeset, :login)
    password = get_field(changeset, :password)

    if login == "" || password == "" do
      changeset
    else
      credential =  Accounts.get_credential_by(login: login)

      if credential do
        case Bcrypt.check_pass(credential, password) do
          {:ok, credential} ->
            {:ok, token, _claims} = JournalWeb.Guardian.encode_and_sign(credential)
            put_change(changeset, :token, token)
          {:error, _} ->
            add_error(changeset, :login, "invalid")
        end
      else
        add_error(changeset, :login, "invalid")
      end
    end
  end

  # defp validate_credentials( = changeset ) do
  #   changeset
  # end
end
