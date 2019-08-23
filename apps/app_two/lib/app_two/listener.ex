defmodule AppTwo.Listener do
  @moduledoc """
  AppOne listener
  """
  use Dispatcher.Listener

  app_two_hello(payload) do
    AppTwo.hello(payload)
  end

  other(_, _) do
    :nothing
  end
end
