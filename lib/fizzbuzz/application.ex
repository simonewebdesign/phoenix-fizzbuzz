defmodule FizzBuzz.Application do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec
    :ets.new :db, [:named_table, :public, read_concurrency: true]

    # Define workers and child supervisors to be supervised
    children = [
      # Start the endpoint when the application starts
      supervisor(FizzBuzz.Web.Endpoint, []),
      # Start your own worker by calling: FizzBuzz.Worker.start_link(arg1, arg2, arg3)
      # worker(FizzBuzz.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FizzBuzz.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
