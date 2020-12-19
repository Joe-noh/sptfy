defmodule Sptfy.Object.AuthError do
  @type t :: %__MODULE__{}

  defstruct ~w[
    error
    error_description
  ]a

  def new(fields) do
    struct(__MODULE__, Sptfy.Object.Helpers.atomize_keys(fields))
  end
end
