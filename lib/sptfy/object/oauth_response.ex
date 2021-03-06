defmodule Sptfy.Object.OAuthResponse do
  @moduledoc """
  Module for OAuth response struct.
  """

  use Sptfy.Object

  defstruct ~w[
    access_token
    expires_in
    refresh_token
    scope
    token_type
  ]a

  def new(map) do
    attrs =
      map
      |> Map.update!("scope", &String.split/1)
      |> Enum.map(fn {k, v} -> {String.to_existing_atom(k), v} end)

    struct(__MODULE__, attrs)
  end
end
