defmodule Sptfy.Object.AlbumRestriction do
  use Sptfy.Object

  defstruct ~w[
    reason
  ]a

  def new(fields) do
    struct(__MODULE__, Sptfy.Object.Helpers.atomize_keys(fields))
  end
end
