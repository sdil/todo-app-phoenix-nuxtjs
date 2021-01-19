defmodule BackendWeb.Router do
  use BackendWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug
    plug BackendWeb.ApiAuthPlug, otp_app: :backend
  end

  pipeline :api_protected do
    plug Pow.Plug.RequireAuthenticated, error_handler: BackendWeb.ApiAuthErrorHandler
  end

  scope "/api", BackendWeb do
    pipe_through :api

    resources "/registration", RegistrationController, singleton: true, only: [:create]
    resources "/session", SessionController, singleton: true, only: [:create, :delete]
    post "/session/renew", SessionController, :renew
  end


  scope "/api", BackendWeb do
    pipe_through [:api]

    resources "/todos", TodoController
  end

  scope "/api-protected", BackendWeb do
    pipe_through [:api, :api_protected]

    resources "/todos", TodoController
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: BackendWeb.Telemetry
    end

  end
end
