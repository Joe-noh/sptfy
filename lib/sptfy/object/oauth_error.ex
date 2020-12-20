defmodule Sptfy.Object.OAuthError do
  use Sptfy.Object

  defstruct ~w[
    error
    error_description
  ]a

  def new(fields) do
    struct(__MODULE__, Sptfy.Object.Helpers.atomize_keys(fields))
  end
end
