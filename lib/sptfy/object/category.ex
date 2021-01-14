defmodule Sptfy.Object.Category do
  use Sptfy.Object

  alias Sptfy.Object.Image

  defstruct ~w[
    href
    icons
    id
    name
  ]a

  def new(fields) do
    fields =
      fields
      |> Helpers.atomize_keys()
      |> Map.update(:icons, [], fn icons -> Enum.map(icons, &Image.new/1) end)

    struct(__MODULE__, fields)
  end
end
