defmodule Sptfy.Client do
  @moduledoc false

  @type params :: Map.t() | Keyword.t()

  defmacro __using__(_) do
    quote location: :keep do
      import Sptfy.Client
      import Sptfy.Client.BodyMapper
    end
  end

  defmacro get(path, as: fun, query: query, mapping: mapping, return_type: return_type) do
    placeholders = Sptfy.Client.Placeholder.extract(path)

    quote location: :keep do
      @doc Sptfy.Client.Document.build("GET", unquote(path), unquote(placeholders) ++ unquote(query))
      @spec unquote(fun)(token :: String.t(), params :: Sptfy.Client.params()) :: unquote(return_type)
      def unquote(fun)(token, params \\ %{})

      def unquote(fun)(token, params) when is_list(params) do
        unquote(fun)(token, Enum.into(params, %{}))
      end

      def unquote(fun)(token, params) when is_map(params) do
        query_params = Sptfy.Client.Parameter.prepare(params, unquote(query))
        path_params = Sptfy.Client.Parameter.prepare(params, unquote(placeholders))
        filled_path = Sptfy.Client.Placeholder.fill(unquote(path), path_params)

        case Sptfy.Client.HTTP.get(token, filled_path, query_params) do
          {:ok, response} -> Sptfy.Client.ResponseHandler.handle(response, unquote(mapping))
          error -> error
        end
      end
    end
  end

  defmacro post(path, as: fun, query: query, body: body, mapping: mapping, return_type: return_type) do
    placeholders = Sptfy.Client.Placeholder.extract(path)

    quote location: :keep do
      @doc Sptfy.Client.Document.build("POST", unquote(path), unquote(placeholders) ++ unquote(query) ++ unquote(body))
      @spec unquote(fun)(token :: String.t(), params :: Sptfy.Client.params()) :: unquote(return_type)
      def unquote(fun)(token, params \\ %{})

      def unquote(fun)(token, params) when is_list(params) do
        unquote(fun)(token, Enum.into(params, %{}))
      end

      def unquote(fun)(token, params) when is_map(params) do
        query_params = Sptfy.Client.Parameter.prepare(params, unquote(query))
        body_params = Sptfy.Client.Parameter.prepare(params, unquote(body))
        path_params = Sptfy.Client.Parameter.prepare(params, unquote(placeholders))
        filled_path = Sptfy.Client.Placeholder.fill(unquote(path), path_params)

        case Sptfy.Client.HTTP.post(token, filled_path, query_params, body_params) do
          {:ok, response} -> Sptfy.Client.ResponseHandler.handle(response, unquote(mapping))
          error -> error
        end
      end
    end
  end

  defmacro put(path, as: fun, query: query, body: body, mapping: mapping, return_type: return_type) do
    placeholders = Sptfy.Client.Placeholder.extract(path)

    quote location: :keep do
      @doc Sptfy.Client.Document.build("PUT", unquote(path), unquote(placeholders) ++ unquote(query) ++ unquote(body))
      @spec unquote(fun)(token :: String.t(), params :: Sptfy.Client.params()) :: unquote(return_type)
      def unquote(fun)(token, params \\ %{})

      def unquote(fun)(token, params) when is_list(params) do
        unquote(fun)(token, Enum.into(params, %{}))
      end

      def unquote(fun)(token, params) when is_map(params) do
        query_params = Sptfy.Client.Parameter.prepare(params, unquote(query))
        body_params = Sptfy.Client.Parameter.prepare(params, unquote(body))
        path_params = Sptfy.Client.Parameter.prepare(params, unquote(placeholders))
        filled_path = Sptfy.Client.Placeholder.fill(unquote(path), path_params)

        case Sptfy.Client.HTTP.put(token, filled_path, query_params, body_params) do
          {:ok, response} -> Sptfy.Client.ResponseHandler.handle(response, unquote(mapping))
          error -> error
        end
      end
    end
  end

  defmacro put_jpeg(path, as: fun, query: query, mapping: mapping, return_type: return_type) do
    placeholders = Sptfy.Client.Placeholder.extract(path)

    quote location: :keep do
      @doc Sptfy.Client.Document.build("PUT", unquote(path), unquote(placeholders) ++ unquote(query))
      @spec unquote(fun)(token :: String.t(), body :: binary(), params :: Sptfy.Client.params()) :: unquote(return_type)
      def unquote(fun)(token, body, params \\ %{})

      def unquote(fun)(token, body, params) when is_list(params) do
        unquote(fun)(token, body, Enum.into(params, %{}))
      end

      def unquote(fun)(token, body, params) when is_map(params) do
        query_params = Sptfy.Client.Parameter.prepare(params, unquote(query))
        path_params = Sptfy.Client.Parameter.prepare(params, unquote(placeholders))
        filled_path = Sptfy.Client.Placeholder.fill(unquote(path), path_params)

        case Sptfy.Client.HTTP.put_jpeg(token, filled_path, query_params, body) do
          {:ok, response} -> Sptfy.Client.ResponseHandler.handle(response, unquote(mapping))
          error -> error
        end
      end
    end
  end

  defmacro delete(path, as: fun, query: query, body: body, mapping: mapping, return_type: return_type) do
    placeholders = Sptfy.Client.Placeholder.extract(path)

    quote location: :keep do
      @doc Sptfy.Client.Document.build("DELETE", unquote(path), unquote(placeholders) ++ unquote(query) ++ unquote(body))
      @spec unquote(fun)(token :: String.t(), params :: Sptfy.Client.params()) :: unquote(return_type)
      def unquote(fun)(token, params \\ %{})

      def unquote(fun)(token, params) when is_list(params) do
        unquote(fun)(token, Enum.into(params, %{}))
      end

      def unquote(fun)(token, params) when is_map(params) do
        query_params = Sptfy.Client.Parameter.prepare(params, unquote(query))
        body_params = Sptfy.Client.Parameter.prepare(params, unquote(body))
        path_params = Sptfy.Client.Parameter.prepare(params, unquote(placeholders))
        filled_path = Sptfy.Client.Placeholder.fill(unquote(path), path_params)

        case Sptfy.Client.HTTP.delete(token, filled_path, query_params, body_params) do
          {:ok, response} -> Sptfy.Client.ResponseHandler.handle(response, unquote(mapping))
          error -> error
        end
      end
    end
  end
end
