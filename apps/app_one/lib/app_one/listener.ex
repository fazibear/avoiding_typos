defmodule AppOne.Listener do
  @moduledoc """
  AppOne listener
  """
  use Dispatcher.Listener

  def on_message(%{name: "app_one_hello", payload: payload}) do
    AppOne.hello(payload)
  end

  def on_message(_), do: :nothing
end
