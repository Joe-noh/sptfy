defmodule Sptfy.Client.BodyMapper do
  @moduledoc false

  @type t :: %__MODULE__{}

  defstruct ~w[
    fun
    key
  ]a

  @spec map(json :: map() | list(map()), mapping :: t()) :: :ok | {:ok, map()} | {:ok, [map()]} | {:ok, map(), String.t()}
  def map(json, %__MODULE__{fun: fun, key: nil}) do
    fun.(json)
  end

  def map(json, %__MODULE__{fun: fun, key: key}) do
    Map.get(json, key) |> fun.()
  end

  @spec single(module :: module()) :: t()
  def single(module) do
    %__MODULE__{fun: fn fields -> {:ok, module.new(fields)} end}
  end

  defp do_single(module) do
    fn
      nil -> nil
      fields -> module.new(fields)
    end
  end

  @spec list_of(module :: module(), key :: String.t() | nil) :: t()
  def list_of(module, key \\ nil) do
    single_fun = do_single(module)
    %__MODULE__{fun: fn list -> {:ok, Enum.map(list, single_fun)} end, key: key}
  end

  @spec paged(module :: module(), key :: String.t() | nil) :: t()
  def paged(module, key \\ nil) do
    %__MODULE__{fun: fn fields -> {:ok, Sptfy.Object.Paging.new(fields, module)} end, key: key}
  end

  @spec paged_with_message(module :: module(), key :: String.t() | nil) :: t()
  def paged_with_message(module, key \\ nil) do
    fun = fn fields ->
      %{"message" => message, ^key => pagign_fields} = fields
      paging = Sptfy.Object.Paging.new(pagign_fields, module)

      {:ok, paging, message}
    end

    %__MODULE__{fun: fun, key: nil}
  end

  @spec cursor_paged(module :: module()) :: t()
  def cursor_paged(module) do
    %__MODULE__{fun: fn fields -> {:ok, Sptfy.Object.CursorPaging.new(fields, module)} end}
  end

  @spec as_is(key :: String.t() | nil) :: t()
  def as_is(key \\ nil) do
    %__MODULE__{fun: fn fields -> {:ok, fields} end, key: key}
  end

  @spec ok :: t()
  def ok do
    %__MODULE__{fun: fn _ -> :ok end}
  end
end
