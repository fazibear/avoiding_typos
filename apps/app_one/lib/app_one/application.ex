defmodule AppOne.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      AppOne.Listener
      # Starts a worker by calling: AppOne.Worker.start_link(arg)
      # {AppOne.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AppOne.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
