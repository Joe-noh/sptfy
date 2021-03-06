defmodule Sptfy.Client.ReturnType do
  @moduledoc false

  @doc false
  @spec ast(mapping :: Sptfy.Client.BodyMapper.mapping()) :: tuple() | :ok | nil
  def ast({:single, module: module}) do
    ok(t(module))
  end

  def ast({:list, opts}) do
    module = Keyword.get(opts, :module)

    ok([t(module)])
  end

  def ast({:paging, _opts}) do
    ok(t(Sptfy.Object.Paging))
  end

  def ast({:paging_with_message, _opts}) do
    {:{}, [], [:ok, t(Sptfy.Object.Paging), t(String)]}
  end

  def ast({:cursor_paging, _opts}) do
    ok(t(Sptfy.Object.CursorPaging))
  end

  def ast(:as_is) do
    nil
  end

  def ast({:as_is, _opts}) do
    nil
  end

  def ast(:ok) do
    :ok
  end

  @doc false
  @spec or_error(ast :: tuple()) :: tuple()
  def or_error(ast) do
    {:|, [], [ast, {:|, [], [error: t(Sptfy.Object.Error), error: t(Mint.Types, :error)]}]}
  end

  defp t(module, name \\ :t) do
    {{:., [], [module, name]}, [], []}
  end

  defp ok(ast) do
    {:{}, [], [:ok, ast]}
  end
end
