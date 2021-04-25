defmodule Inmana.Supplies.Scheduler do
  use GenServer
  alias Inmana.Supplies.ExpirationNotification

  # CLIENT
  def start_link(_state) do
    GenServer.start_link(__MODULE__, %{})
  end

  # SERVER

  @impl true
  def init(state \\ %{}) do
    schedule_notification()
    {:ok, state}
  end

  @impl true
  def handle_info(:generate, state) do
    ExpirationNotification.send()

    schedule_notification()

    {:noreply, state}
  end

  # Essa função realiza um envio para o proprio GenServer de 10 em 10 segundos
  # tempo no ultimo argumento está como ms
  # Na nossa aplicação poderiamos multiplicar os valores de tempo até chegar em uma semana

  defp schedule_notification do
    Process.send_after(self(), :generate, 1000 * 10)
  end

  # Apenas exemplo
  # # async
  # def handle_cast({:put, key, value}, state) do
  #   {:noreply, Map.put(state, key, value)}
  # end

  # # sync
  # def handle_call({:get, key}, _from, state) do
  #   {:reply, Map.get(state, key), state}
  # end
end
