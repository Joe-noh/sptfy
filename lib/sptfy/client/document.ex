defmodule Sptfy.Client.Document do
  @moduledoc false

  def build(method, path, []) do
    """
    #{method} #{path}
    """
  end

  def build(method, path, params) do
    """
    #{method} #{path}

    ## Parameters

    #{parameter_doc(params)}
    """
  end

  defp parameter_doc(schemas) do
    schemas
    |> Enum.map(&parameter_doc_line/1)
    |> Enum.filter(& &1)
    |> Enum.join("\n")
  end

  defp parameter_doc_line({key, opts}) do
    cond do
      Keyword.has_key?(opts, :fixed) -> nil
      Keyword.has_key?(opts, :required) -> "- `#{key}`: required"
      true -> "- `#{key}`"
    end
  end

  defp parameter_doc_line(key) do
    "- `#{key}`"
  end
end
