defmodule Sptfy.Client do
  @moduledoc false

  @type params :: Map.t() | Keyword.t()

  alias Sptfy.Client.{Document, HTTP, Parameter, Placeholder, ResponseHandler, ReturnType}

  defmacro __using__(_) do
    quote location: :keep do
      import Sptfy.Client
      import Sptfy.Client.BodyMapper
    end
  end

  defmacro get(path, opts) do
    [as: fun, query: query, mapping: mapping] = Keyword.take(opts, [:as, :query, :mapping])

    placeholders = Placeholder.extract(path)
    placeholder_keys = Keyword.keys(placeholders)
    type_ast = ReturnType.ast(mapping) || Keyword.get(opts, :return_type)

    quote location: :keep do
      @doc Document.build("GET", unquote(path), unquote(placeholders) ++ unquote(query))
      @spec unquote(fun)(token :: String.t(), params :: Sptfy.Client.params()) :: unquote(type_ast)
      def unquote(fun)(token, params \\ %{})

      def unquote(fun)(token, params) when is_list(params) do
        unquote(fun)(token, Enum.into(params, %{}))
      end

      def unquote(fun)(token, params) when is_map(params) do
        query_params = Parameter.prepare(params, unquote(query))
        path_params = Parameter.prepare(params, unquote(placeholder_keys))
        filled_path = Placeholder.fill(unquote(path), path_params)

        Parameter.check_required!(params, unquote(placeholders) ++ unquote(query))

        case HTTP.get(token, filled_path, query_params) do
          {:ok, response} -> ResponseHandler.handle(response, unquote(mapping))
          error -> error
        end
      end
    end
  end

  defmacro post(path, opts) do
    [as: fun, query: query, body: body, mapping: mapping] = Keyword.take(opts, [:as, :query, :body, :mapping])

    placeholders = Placeholder.extract(path)
    placeholder_keys = Keyword.keys(placeholders)
    type_ast = ReturnType.ast(mapping) || Keyword.get(opts, :return_type)

    quote location: :keep do
      @doc Document.build("POST", unquote(path), unquote(placeholders) ++ unquote(query) ++ unquote(body))
      @spec unquote(fun)(token :: String.t(), params :: Sptfy.Client.params()) :: unquote(type_ast)
      def unquote(fun)(token, params \\ %{})

      def unquote(fun)(token, params) when is_list(params) do
        unquote(fun)(token, Enum.into(params, %{}))
      end

      def unquote(fun)(token, params) when is_map(params) do
        query_params = Parameter.prepare(params, unquote(query))
        body_params = Parameter.prepare(params, unquote(body))
        path_params = Parameter.prepare(params, unquote(placeholder_keys))
        filled_path = Placeholder.fill(unquote(path), path_params)

        Parameter.check_required!(params, unquote(placeholders) ++ unquote(query) ++ unquote(body))

        case HTTP.post(token, filled_path, query_params, body_params) do
          {:ok, response} -> ResponseHandler.handle(response, unquote(mapping))
          error -> error
        end
      end
    end
  end

  defmacro put(path, opts) do
    [as: fun, query: query, body: body, mapping: mapping] = Keyword.take(opts, [:as, :query, :body, :mapping])

    placeholders = Placeholder.extract(path)
    placeholder_keys = Keyword.keys(placeholders)
    type_ast = ReturnType.ast(mapping) || Keyword.get(opts, :return_type)

    quote location: :keep do
      @doc Document.build("PUT", unquote(path), unquote(placeholders) ++ unquote(query) ++ unquote(body))
      @spec unquote(fun)(token :: String.t(), params :: Sptfy.Client.params()) :: unquote(type_ast)
      def unquote(fun)(token, params \\ %{})

      def unquote(fun)(token, params) when is_list(params) do
        unquote(fun)(token, Enum.into(params, %{}))
      end

      def unquote(fun)(token, params) when is_map(params) do
        query_params = Parameter.prepare(params, unquote(query))
        body_params = Parameter.prepare(params, unquote(body))
        path_params = Parameter.prepare(params, unquote(placeholder_keys))
        filled_path = Placeholder.fill(unquote(path), path_params)

        Parameter.check_required!(params, unquote(placeholders) ++ unquote(query) ++ unquote(body))

        case HTTP.put(token, filled_path, query_params, body_params) do
          {:ok, response} -> ResponseHandler.handle(response, unquote(mapping))
          error -> error
        end
      end
    end
  end

  defmacro put_jpeg(path, opts) do
    [as: fun, query: query, mapping: mapping] = Keyword.take(opts, [:as, :query, :mapping])

    placeholders = Placeholder.extract(path)
    placeholder_keys = Keyword.keys(placeholders)
    type_ast = ReturnType.ast(mapping) || Keyword.get(opts, :return_type)

    quote location: :keep do
      @doc Document.build("PUT", unquote(path), unquote(placeholders) ++ unquote(query))
      @spec unquote(fun)(token :: String.t(), body :: binary(), params :: Sptfy.Client.params()) :: unquote(type_ast)
      def unquote(fun)(token, body, params \\ %{})

      def unquote(fun)(token, body, params) when is_list(params) do
        unquote(fun)(token, body, Enum.into(params, %{}))
      end

      def unquote(fun)(token, body, params) when is_map(params) do
        query_params = Parameter.prepare(params, unquote(query))
        path_params = Parameter.prepare(params, unquote(placeholder_keys))
        filled_path = Placeholder.fill(unquote(path), path_params)

        Parameter.check_required!(params, unquote(placeholders) ++ unquote(query))

        case HTTP.put_jpeg(token, filled_path, query_params, body) do
          {:ok, response} -> ResponseHandler.handle(response, unquote(mapping))
          error -> error
        end
      end
    end
  end

  defmacro delete(path, opts) do
    [as: fun, query: query, body: body, mapping: mapping] = Keyword.take(opts, [:as, :query, :body, :mapping])

    placeholders = Placeholder.extract(path)
    placeholder_keys = Keyword.keys(placeholders)
    type_ast = ReturnType.ast(mapping) || Keyword.get(opts, :return_type)

    quote location: :keep do
      @doc Document.build("DELETE", unquote(path), unquote(placeholders) ++ unquote(query) ++ unquote(body))
      @spec unquote(fun)(token :: String.t(), params :: Sptfy.Client.params()) :: unquote(type_ast)
      def unquote(fun)(token, params \\ %{})

      def unquote(fun)(token, params) when is_list(params) do
        unquote(fun)(token, Enum.into(params, %{}))
      end

      def unquote(fun)(token, params) when is_map(params) do
        query_params = Parameter.prepare(params, unquote(query))
        body_params = Parameter.prepare(params, unquote(body))
        path_params = Parameter.prepare(params, unquote(placeholder_keys))
        filled_path = Placeholder.fill(unquote(path), path_params)

        Parameter.check_required!(params, unquote(placeholders) ++ unquote(query) ++ unquote(body))

        case HTTP.delete(token, filled_path, query_params, body_params) do
          {:ok, response} -> ResponseHandler.handle(response, unquote(mapping))
          error -> error
        end
      end
    end
  end
end
