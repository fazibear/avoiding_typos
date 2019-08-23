defmodule AppOne.Listener do
  @moduledoc """
  AppOne listener
  """
  use Dispatcher.Listener

  app_one_hello(payload) do
    AppOne.hello(payload)
  end

  other(_, _) do
    :nothing
  end
end
