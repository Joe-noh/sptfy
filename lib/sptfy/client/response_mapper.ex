defmodule Sptfy.Client.ResponseMapper do
  def map(json, {key, fun}) do
    Map.get(json, key) |> fun.()
  end

  def list_of(module) do
    fn list -> Enum.map(list, &module.new/1) end
  end
end
