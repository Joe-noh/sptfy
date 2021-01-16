defmodule Sptfy.Object.CursorPaging do
  use Sptfy.Object

  alias Sptfy.Object.Cursors

  defstruct ~w[
    href
    items
    limit
    next
    cursors
    total
  ]a

  def new(fields, item_module) do
    fields =
      fields
      |> Helpers.atomize_keys()
      |> Map.update(:items, [], fn items -> Enum.map(items, &item_module.new/1) end)
      |> Map.update(:cursors, nil, &Cursors.new/1)

    struct(__MODULE__, fields)
  end
end
