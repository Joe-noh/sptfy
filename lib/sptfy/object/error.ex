defmodule Sptfy.Object.Error do
  @moduledoc """
  Module for API error struct.
  """

  use Sptfy.Object

  defstruct ~w[
    message
    status
  ]a
end
