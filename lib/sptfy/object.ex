defmodule Sptfy.Object do
  @callback new(fields :: map()) :: map()

  defmacro __using__(_) do
    quote do
      @behaviour Sptfy.Object
      @type t :: %__MODULE__{}

      @doc false
      def new(fields) do
        struct(__MODULE__, Sptfy.Object.Helpers.atomize_keys(fields))
      end

      defoverridable new: 1
    end
  end
end
