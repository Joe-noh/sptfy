defmodule Sptfy.Object.Device do
  use Sptfy.Object

  defstruct ~w[
    id
    is_active
    is_private_session
    is_restricted
    name
    type
    volume_percent
  ]a
end
