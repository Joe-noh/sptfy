defmodule Sptfy.Client do
  defmacro get(path, as: function, query: query, mapping: mapping) do
    placeholders = Sptfy.Client.Placeholder.extract(path)

    quote do
      @doc """
      GET #{unquote(path)}
      """
      def unquote(function)(token, params) when is_list(params) do
        unquote(function)(token, Enum.into(params, %{}))
      end

      def unquote(function)(token, params) when is_map(params) do
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
