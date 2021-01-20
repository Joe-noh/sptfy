defmodule Sptfy.Client.ParameterTest do
  use ExUnit.Case, async: true

  alias Sptfy.Client.Parameter

  describe "prepare/2" do
    setup do
      %{schema: [:limit, :offset, {:type, fixed: "user"}]}
    end

    test "exclude unpermitted keys", %{schema: schema} do
      assert Parameter.prepare(%{limit: 10, abc: 1}, schema) == %{limit: 10, type: "user"}
    end

    test "cannot overwrite fixed value", %{schema: schema} do
      assert Parameter.prepare(%{type: "artist"}, schema) == %{type: "user"}
    end
  end
end
