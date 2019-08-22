defmodule Dispatcher.Listener do
  @moduledoc """
  Listener for messages from dispatcher
  """
  @callback on_message(message :: map) :: any

  @doc false
  defmacro __using__(_opts) do
    quote location: :keep do
      @behaviour Dispatcher.Listener

      use GenStage

      def start_link(opts) do
        GenStage.start_link(__MODULE__, opts, name: __MODULE__)
      end

      def init(state) do
        {:consumer, state, subscribe_to: [Dispatcher]}
      end

      def handle_events(messages, _from, state) do
        for message <- messages do
          on_message(message)
        end

        {:noreply, [], state}
      end

      def on_message(_), do: :nothing

      defoverridable on_message: 1
    end
  end
end
