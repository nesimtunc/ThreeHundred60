defmodule Threehundred60.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Threehundred60.Repo,
      # Start the Telemetry supervisor
      Threehundred60Web.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Threehundred60.PubSub},
      # Start the Endpoint (http/https)
      Threehundred60Web.Endpoint
      # Start a worker by calling: Threehundred60.Worker.start_link(arg)
      # {Threehundred60.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Threehundred60.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Threehundred60Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
