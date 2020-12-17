defmodule Sptfy.Object.TrackRestriction do
  @type t :: %__MODULE__{}

  defstruct ~w[
    reason
  ]a

  def new(fields) do
    struct(__MODULE__, Sptfy.Object.Helpers.atomize_keys(fields))
  end
end
