defmodule Sptfy.Client.BodyMapper do
  @moduledoc false

  @type mapped_result :: :ok | {:ok, map()} | {:ok, [map()]} | {:ok, map(), String.t()}
  @type mapping :: single_mapping() | list_mapping() | paging_mapping() | as_is_mapping() | :ok
  @typep single_mapping :: {:single, module: module()} | {:single, module: module(), key: String.t()}
  @typep list_mapping :: {:list, module: module()} | {:list, module: module(), key: String.t()}
  @typep paging_mapping ::
           {:paging, module: module()}
           | {:paging, module: module(), key: String.t()}
           | {:paging_with_message, module: module(), key: String.t()}
           | {:cursor_paging, module: module()}
  @typep as_is_mapping :: :as_is | {:as_is, key: String.t()}

  @spec map(json :: map() | list(map()), mapping :: mapping()) :: mapped_result()
  def map(json, {:single, module: module}) do
    {:ok, new_struct(module, json)}
  end

  def map(json, {:list, module: module}) do
    structs = json |> Enum.map(fn fields -> new_struct(module, fields) end)

    {:ok, structs}
  end

  def map(json, {:list, module: module, key: key}) do
    structs = json |> Map.get(key) |> Enum.map(fn fields -> new_struct(module, fields) end)

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

  defp new_struct(_module, nil) do
    nil
  end

  defp new_struct(module, fields) do
    module.new(fields)
  end
end
