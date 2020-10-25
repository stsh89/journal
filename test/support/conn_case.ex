defmodule JournalWeb.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common data structures and query the data layer.

  Finally, if the test case interacts with the database,
  we enable the SQL sandbox, so changes done to the database
  are reverted at the end of every test. If you are using
  PostgreSQL, you can even run database tests asynchronously
  by setting `use JournalWeb.ConnCase, async: true`, although
  this option is not recommended for other databases.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      import Plug.Conn
      import Phoenix.ConnTest
      import JournalWeb.ConnCase

      alias JournalWeb.Router.Helpers, as: Routes

      # The default endpoint for testing
      @endpoint JournalWeb.Endpoint
    end
  end

  @default_opts [
    store: :cookie,
    key: "foobar",
    encryption_salt: "encrypted cookie salt",
    signing_salt: "signing salt",
    log: false
  ]

  @signing_opts Plug.Session.init(Keyword.put(@default_opts, :encrypt, false))

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Journal.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Journal.Repo, {:shared, self()})
    end

    conn =
      if tags[:authenticated] do
        {:ok, c} =
          Journal.Accounts.create_credential(%{
            login: "stan",
            password_hash: Bcrypt.add_hash("password") |> Map.get(:password_hash)
          })

        {:ok, token, _claims} = JournalWeb.Guardian.encode_and_sign(c)

        Phoenix.ConnTest.build_conn()
        |> Plug.Session.call(@signing_opts)
        |> Plug.Conn.fetch_session
        |> Plug.Conn.put_session(:token, token)
      else
        Phoenix.ConnTest.build_conn()
      end

    {:ok, conn: conn}
  end
end
