defmodule Sptfy.Object do
  @callback new(fields :: map()) :: map()

  defmacro __using__(_) do
    quote do
      @behaviour Sptfy.Object
      @type t :: %__MODULE__{}

      alias Sptfy.Object.Helpers

      @doc false
      def new(fields) do
        struct(__MODULE__, Helpers.atomize_keys(fields))
      end

      defoverridable new: 1
    end
  end
end
