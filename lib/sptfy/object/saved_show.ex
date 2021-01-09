defmodule Sptfy.Object.SavedShow do
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
      |> Map.update(:show, nil, &SimplifiedShow.new/1)

    struct(__MODULE__, fields)
  end
end
