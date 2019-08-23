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
      import Dispatcher.Listener

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

  Enum.each(Dispatcher.Message.list(), fn message ->
    defmacro unquote(message)(payload, block) do
      message = Macro.escape(unquote(message))
      payload = Macro.escape(payload)
      block = Macro.escape(block, unquote: true)

      quote bind_quoted: [message: message, payload: payload, block: block] do
        def on_message(%{name: unquote(message), payload: unquote(payload)}), do: unquote(block)
      end
    end
  end)

  defmacro other(name, payload, block) do
    name = Macro.escape(name)
    payload = Macro.escape(payload)
    block = Macro.escape(block, unquote: true)

    quote bind_quoted: [name: name, payload: payload, block: block] do
      def on_message(%{name: unquote(name), payload: unquote(payload)}), do: unquote(block)
    end
  end
end
