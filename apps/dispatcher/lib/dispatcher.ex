defmodule Dispatcher do
  @moduledoc """
  Dispatcher is for dispatching messages.
  """

  use GenStage
  require Logger

  def start_link(_opts) do
    GenStage.start_link(__MODULE__, [], name: __MODULE__)
  end

  def message(message) do
    GenStage.cast(__MODULE__, message)
  end

  def init(_) do
    {:producer, %{enabled: true}, dispatcher: GenStage.BroadcastDispatcher}
  end

  def handle_info(:disable, state) do
    {:noreply, [], %{state | enabled: false}}
  end

  def handle_info(:enable, state) do
    {:noreply, [], %{state | enabled: true}}
  end

  def handle_cast(message, %{enabled: true} = state) when is_map(message) do
    Logger.info("Dispatch message: #{inspect(message)}")
    {:noreply, [message], state}
  end

  def handle_demand(_demand, state), do: {:noreply, [], state}
end
