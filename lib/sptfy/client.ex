defmodule Sptfy.Client do
  @base_url "https://api.spotify.com"

  defmacro get(path, as: function, query: query) do
    _placeholders = parse_placeholders(path)

    quote do
      @doc """
      #{unquote(path)}
      """
      def unquote(function)(params) when is_list(params) do
        unquote(function)(params |> Enum.into(%{}))
      end

      def unquote(function)(params) when is_map(params) do
        qs = params |> Map.take(unquote(query)) |> Enum.map(fn
          {k, v} when is_list(v) -> {k, Enum.join(v, ",")}
          {k, v} -> {k, v}
        end)
        |> URI.encode_query

        url = unquote(@base_url) <> unquote(path) <> "?" <> qs

        Finch.build(:get, url) |> Finch.request(Sptfy.Finch)
      end
    end
  end

  defp parse_placeholders(path) do
    Regex.scan(~r/:(\w+)/, path) |> Enum.map(fn [_whole, name] -> name end)
  end
end
