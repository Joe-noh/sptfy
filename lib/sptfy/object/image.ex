defmodule Sptfy.Object.Image do
  @moduledoc """
  Module for image struct.
  """

  use Sptfy.Object

  defstruct ~w[
    height
    url
    width
  ]a
end
