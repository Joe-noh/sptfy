defmodule Sptfy.Object.OAuthError do
  @moduledoc """
  Module for OAuth related error struct.
  """

  use Sptfy.Object

  defstruct ~w[
    error
    error_description
  ]a
end
