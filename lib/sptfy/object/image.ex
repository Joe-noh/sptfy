defmodule Sptfy.Object.Image do
  @type t :: %__MODULE__{}

  defstruct ~w[
    height
    url
    width
  ]a

  def new(fields) do
    struct(__MODULE__, Sptfy.Object.Helpers.atomize_keys(fields))
  end
end
