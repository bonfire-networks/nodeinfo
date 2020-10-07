# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :nodeinfo,
  ecto_repos: [Nodeinfo.Repo]

# Configures the endpoint
config :nodeinfo, NodeinfoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ZIHZR8PHOCE/CP9SbMcl8qwh8T+2/hhzRDxxl8FSf0hqcn/7TqTVixGA//B/MbKu",
  render_errors: [view: NodeinfoWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Nodeinfo.PubSub,
  live_view: [signing_salt: "YFmzf02Q"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
