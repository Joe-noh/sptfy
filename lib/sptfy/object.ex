defmodule Sptfy.Object do
  @moduledoc false

  @callback new(fields :: map()) :: map()

  defmacro __using__(_) do
    quote do
      @behaviour Sptfy.Object
      @type t :: %__MODULE__{}

      alias Sptfy.Object.Helpers

      @doc false
      def new(nil), do: nil
      def new(fields), do: struct(__MODULE__, Helpers.atomize_keys(fields))

      defoverridable new: 1
    end
  end
end
