defmodule AppTwo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      AppTwo.Listener,
      # Starts a worker by calling: AppTwo.Worker.start_link(arg)
      # {AppTwo.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AppTwo.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
