defmodule Sptfy.Object.Context do
  @moduledoc """
  Module for context struct.
  """

  use Sptfy.Object

  defstruct ~w[
    type
    href
    external_urls
    uri
  ]a
end
