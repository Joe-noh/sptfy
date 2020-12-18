defmodule Sptfy.Client.ResponseMapper do
  def map(json, fun) when is_function(fun) do
    fun.(json)
  end

  def map(json, {key, fun}) when is_function(fun) do
    Map.get(json, key) |> fun.()
  end

  def single(module) do
    &module.new/1
  end

  def list_of(module) do
    &Enum.map(&1, single(module))
  end

  def as_is() do
    & &1
  end
end
