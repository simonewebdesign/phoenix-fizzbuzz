# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :fizzbuzz,
  namespace: FizzBuzz

# Configures the endpoint
config :fizzbuzz, FizzBuzz.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "tmk+sSAFVXroz6Xpa+s1HjLjjblPHgPjr9YHjP9RtnT692FgG2g0y68pnYDqVf1/",
  render_errors: [view: FizzBuzz.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: FizzBuzz.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
