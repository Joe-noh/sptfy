defmodule Sptfy.Object.Error do
  use Sptfy.Object

  defstruct ~w[
    message
    status
  ]a

  def new(fields) do
    struct(__MODULE__, Sptfy.Object.Helpers.atomize_keys(fields))
  end
end