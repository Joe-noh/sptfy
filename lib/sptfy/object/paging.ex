defmodule Sptfy.Object.Paging do
  use Sptfy.Object

  defstruct ~w[
    href
    items
    limit
    next
    offset
    previous
    total
  ]a

  def new(fields, item_module) do
    fields =
      fields
      |> Helpers.atomize_keys()
      |> Map.update(:items, [], fn items -> Enum.map(items, &item_module.new/1) end)

    struct(__MODULE__, fields)
  end
end
