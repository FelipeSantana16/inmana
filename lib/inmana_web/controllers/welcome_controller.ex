defmodule InmanaWeb.WelcomeController do
  # Dizemos qual é o tipo desse modulo
  use InmanaWeb, :controller

  # Criamos um alias pra usar apenas Welcomer em vez do nome completo Inmana.Welcomer
  alias Inmana.Welcomer

  # conn é de conexao
  def index(conn, params) do
    params
    |> Welcomer.welcome()
    |> handle_response(conn)
  end

  # Os dados passados pra handle_response vem do model welcomer
  defp handle_response({:ok, message}, conn), do: render_response(conn, message, :ok)

  defp handle_response({:error, message}, conn), do: render_response(conn, message, :bad_request)

  defp render_response(conn, message, status) do
    conn
    |> put_status(status)
    |> json(%{message: message})
  end
end
