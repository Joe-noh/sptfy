defmodule Sptfy.Object.OAuthError do
  use Sptfy.Object

  defstruct ~w[
    error
    error_description
  ]a
end
