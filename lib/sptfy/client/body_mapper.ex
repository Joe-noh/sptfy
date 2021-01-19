defmodule Sptfy.Client.BodyMapper do
  @moduledoc false

  @type t :: %__MODULE__{}

  defstruct ~w[
    fun
    key
  ]a

  @spec map(json :: map() | list(map()), mapping :: t()) :: :ok | {:ok, map()} | {:ok, [map()]} | {:ok, map(), String.t()}
  def map(json, {:single, module: module}) do
    {:ok, module.new(json)}
  end

  def map(json, {:list, module: module}) do
    structs = json |> Enum.map(&module.new/1)

    {:ok, structs}
  end

  def map(json, {:list, module: module, key: key}) do
    structs = json |> Map.get(key) |> Enum.map(&module.new/1)

    {:ok, structs}
  end

  def map(json, {:paging, module: module}) do
    paging = json |> Sptfy.Object.Paging.new(module)

    {:ok, paging}
  end

  def map(json, {:paging, module: module, key: key}) do
    paging = json |> Map.get(key) |> Sptfy.Object.Paging.new(module)

    {:ok, paging}
  end

  def map(json, {:paging_with_message, module: module, key: key}) do
    %{"message" => message, ^key => fields} = json
    paging = Sptfy.Object.Paging.new(fields, module)

    {:ok, paging, message}
  end

  def map(json, {:cursor_paging, module: module}) do
    paging = json |> Sptfy.Object.CursorPaging.new(module)

    {:ok, paging}
  end

  def map(json, :as_is) do
    {:ok, json}
  end

  def map(json, {:as_is, key: key}) do
    {:ok, Map.get(json, key)}
  end

  def map(_json, :ok) do
    :ok
  end
end
