defmodule Sptfy.OAuth.Response do
  defstruct ~w[
    access_token
    refresh_token
    scope
    expires_in
    token_type
  ]a

  @doc false
  def new(map) do
    attrs =
      map
      |> Map.update!("scope", &String.split/1)
      |> Enum.map(fn {k, v} -> {String.to_existing_atom(k), v} end)

    struct(__MODULE__, attrs)
  end
end
