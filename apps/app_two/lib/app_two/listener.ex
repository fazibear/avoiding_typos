defmodule AppTwo.Listener do
  @moduledoc """
  AppOne listener
  """
  use Dispatcher.Listener

  def on_message(%{name: "app_two_hello", payload: payload}) do
    AppTwo.hello(payload)
  end

  def on_message(action), do: action
end
