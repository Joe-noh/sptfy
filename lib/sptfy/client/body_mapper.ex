defmodule Sptfy.Client.BodyMapper do
  @moduledoc false

  @type t :: %__MODULE__{}

  defstruct ~w[
    fun
    key
  ]a

  @spec map(json :: map(), mapping :: t()) :: map() | [map()]
  def map(json, %__MODULE__{fun: fun, key: nil}) do
    fun.(json)
  end

  def map(json, %__MODULE__{fun: fun, key: key}) do
    Map.get(json, key) |> fun.()
  end

  @spec single(module :: module()) :: t()
  def single(module) do
    %__MODULE__{fun: &module.new/1}
  end

  @spec list_of(module :: module(), key :: String.t()) :: t()
  def list_of(module, key) do
    single_fun = single(module).fun
    %__MODULE__{fun: &Enum.map(&1, single_fun), key: key}
  end

  @spec as_is :: t()
  def as_is do
    %__MODULE__{fun: & &1}
  end
end
