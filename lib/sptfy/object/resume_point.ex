defmodule Sptfy.Object.ResumePoint do
  @moduledoc """
  Module for resume point struct.
  """

  use Sptfy.Object

  defstruct ~w[
    fully_played
    resume_position_ms
  ]a
end
