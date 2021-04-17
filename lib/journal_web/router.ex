defmodule JournalWeb.Router do
  use JournalWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug JournalWeb.Plugs.AuthPlug
  end

  scope "/", JournalWeb do
    pipe_through [:browser, :auth]

    get "/", NoteController, :index
    resources "/notes", NoteController
    resources "/shared_notes", SharedNoteController, only: [:create, :delete]
    delete "/sessions", SessionController, :delete
  end

  scope "/", JournalWeb do
    pipe_through :browser

    resources "/sessions", SessionController, only: [:new, :create]
    resources "/shared", SharedNoteController, only: [:show], param: "sharing_code"
  end

  # Other scopes may use custom stacks.
  # scope "/api", JournalWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard
  import Phoenix.LiveDashboard.Router

  scope "/" do
    pipe_through [:browser, :auth]
    live_dashboard "/dashboard", metrics: JournalWeb.Telemetry
  end
end
