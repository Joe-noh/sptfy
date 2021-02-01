defmodule Sptfy.Object.SavedShow do
  @moduledoc """
  Module for saved show struct.
  """

  use Sptfy.Object

  alias Sptfy.Object.SimplifiedShow

  defstruct ~w[
    added_at
    show
  ]a

  def new(fields) do
    fields =
      fields
      |> Helpers.atomize_keys()
      |> Map.update(:added_at, nil, &Helpers.parse_timestamp/1)
      |> Map.update(:show, nil, &SimplifiedShow.new/1)

    struct(__MODULE__, fields)
  end
end
