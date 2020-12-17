defmodule Sptfy.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Finch, name: Sptfy.Finch}
    ]

    opts = [strategy: :one_for_one, name: Sptfy.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
