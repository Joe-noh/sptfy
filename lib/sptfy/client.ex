defmodule Sptfy.Client do
  @type params :: Map.t() | Keyword.t()

  defmacro __using__(_) do
    quote location: :keep do
      import Sptfy.Client
      import Sptfy.Client.ResponseMapper
    end
  end

  defmacro get(path, as: fun, query: query, mapping: mapping, return_type: return_type) do
    placeholders = Sptfy.Client.Placeholder.extract(path)

    quote location: :keep do
      @doc """
      GET #{unquote(path)}
      """

      @spec unquote(fun)(token :: String.t(), params :: Sptfy.Client.params()) :: {:ok, unquote(return_type)}
      def unquote(fun)(token, params) when is_list(params) do
        unquote(fun)(token, Enum.into(params, %{}))
      end

      def unquote(fun)(token, params) when is_map(params) do
        query_params = params |> Map.take(unquote(query))
        path_params = params |> Map.take(unquote(placeholders))
        filled_path = Sptfy.Client.Placeholder.fill(unquote(path), path_params)

        with {:ok, body} <- Sptfy.Client.HTTP.get(token, filled_path, query_params),
             response = Sptfy.Client.ResponseMapper.map(body, unquote(mapping)) do
          {:ok, response}
        end
      end
    end
  end
end
