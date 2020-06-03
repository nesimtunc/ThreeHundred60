# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :threehundred60,
  ecto_repos: [Threehundred60.Repo]

# Configures the endpoint
config :threehundred60, Threehundred60Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ZBdg4u3ma+M30IM9DMNxEJHRY9y8xR4jBXlBHGw6CpO+xGpa9dci8Sk4wAzwgHLm",
  render_errors: [view: Threehundred60Web.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Threehundred60.PubSub,
  live_view: [signing_salt: "NIBRi5Nq"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
