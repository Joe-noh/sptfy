defmodule Sptfy.Object do
  @callback new(fields :: map()) :: map()

  defmacro __using__(_) do
    quote do
      @behaviour Sptfy.Object
      @type t :: %__MODULE__{}
    end
  end
end
