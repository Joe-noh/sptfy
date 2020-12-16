defmodule Sptfy.Client do
  @type params :: Map.t() | Keyword.t()

  defmacro get(path, as: fun, query: query, mapping: mapping, return_type: return_type) do
    placeholders = Sptfy.Client.Placeholder.extract(path)

    quote do
      @doc """
      GET #{unquote(path)}
      """

      @spec unquote(fun)(token :: String.t(), params :: Sptfy.Client.params()) :: unquote(return_type)
      def unquote(fun)(token, params) when is_list(params) do
        unquote(fun)(token, Enum.into(params, %{}))
      end

      def unquote(fun)(token, params) when is_map(params) do
        query_params = params |> Map.take(unquote(query))
        path_params = params |> Map.take(unquote(placeholders))
        filled_path = Sptfy.Client.Placeholder.fill(unquote(path), path_params)

        with {:ok, body} <- Sptfy.Client.HTTP.get(token, filled_path, query_params) do
          Sptfy.Client.ResponseMapper.map(body, unquote(mapping))
        end
      end
    end
  end
end
