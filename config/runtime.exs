import Config

config :journal, JournalWeb.Endpoint,
  http: [port: System.get_env("PORT", "4000")]
