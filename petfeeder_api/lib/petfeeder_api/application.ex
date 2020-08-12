defmodule PetfeederApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      PetfeederApiWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: PetfeederApi.PubSub},
      # Start the Endpoint (http/https)
      PetfeederApiWeb.Endpoint
      # Start a worker by calling: PetfeederApi.Worker.start_link(arg)
      # {PetfeederApi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PetfeederApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    PetfeederApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
