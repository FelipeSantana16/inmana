defmodule InmanaWeb.SuppliesController do
  # Dizemos qual é o tipo desse modulo
  use InmanaWeb, :controller

  alias Inmana.Supply
  alias InmanaWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %Supply{} = supply} <- Inmana.create_supply(params) do
      conn
      |> put_status(:created)
      |> render("create.json", supply: supply)
    end
  end
end
