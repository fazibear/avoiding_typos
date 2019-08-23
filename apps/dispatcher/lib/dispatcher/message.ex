defmodule Dispatcher.Message do
  @moduledoc """
  List of all messages
  """

  @list ~w[
      app_one_hello
      app_two_hello
    ]a

  def list, do: @list

  Enum.each(@list, fn message ->
    def unquote(message)(payload \\ nil) do
      GenStage.cast(
        Dispatcher,
        {:message,
         %{
           name: unquote(message),
           payload: payload
         }}
      )
    end
  end)
end
