defmodule InmanaWeb.Router do
  use InmanaWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", InmanaWeb do
    pipe_through :api

    get "/", WelcomeController, :index

    post "/restaurants", RestaurantsController, :create

    resources "/supplies", SuppliesController, only: [:create, :show]

    # Algo que podemos utilizar para criar as rotas para o CRUD de um supply
    # ou restaurant é o resources. Ele cria seguindo o padrao REST todos os paths
    # ou seja, ele cria um path pra get, um pra post, um pra update, um pra delete.
    # a gente pode usar ele assim:
    # resources "/supplies", SuppliesController
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
      live_dashboard "/dashboard", metrics: InmanaWeb.Telemetry
    end
  end
end
