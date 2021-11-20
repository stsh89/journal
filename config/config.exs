# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :journal, JournalWeb.Guardian,
       issuer: "journal",
       secret_key: "6Z6c4ZzoyRRU/r3EWLw19wlYfsj6Ono+X6ya+Ndi6FG+uTcUm0iHMmWqa6YBIbZL"

config :journal,
  ecto_repos: [Journal.Repo]

config :journal, Journal.Repo, migration_timestamps: [type: :timestamptz]

# Configures the endpoint
config :journal, JournalWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "7fVnTaSfYT/aNQk5wN1EI1hdnIASpinLzMXU0+IE978uFdSgTq06PmeZZoHaeV7t",
  render_errors: [view: JournalWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Journal.PubSub,
  live_view: [signing_salt: "NvjdBsS/"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.12.18",
  default: [
    args: ~w(js/app.js --bundle --target=es2016 --outdir=../priv/static/assets),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
