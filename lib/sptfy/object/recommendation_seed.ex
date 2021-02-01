defmodule Sptfy.Object.RecommendationSeed do
  @moduledoc """
  Module for recommendation seed struct.
  """

  use Sptfy.Object

  defstruct ~w[
    after_filtering_size
    after_relinking_size
    href
    id
    initial_pool_size
    type
  ]a

  def new(fields) do
    fields = fields |> Helpers.atomize_keys(underscore: true)

    struct(__MODULE__, fields)
  end
end
