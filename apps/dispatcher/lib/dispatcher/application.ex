defmodule Dispatcher.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Dispatcher,
      # Starts a worker by calling: Dispatcher.Worker.start_link(arg)
      # {Dispatcher.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Dispatcher.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
