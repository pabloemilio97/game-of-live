defmodule GameOfLive.Application do
  use Application

  def start(_type, _args) do
    children = [
      {GameOfLive.LifeCycle, []}
    ]

    opts = [
      strategy: :one_for_one,
      name: __MODULE__]
    Supervisor.start_link(children, opts)
  end
  
end
