defmodule Sptfy.Client.ParameterTest do
  use ExUnit.Case, async: true

  alias Sptfy.Client.Parameter

  describe "prepare/2" do
    setup do
      %{schema: [{:id, required: true}, :limit, :offset, {:type, fixed: "user"}]}
    end

    test "exclude unpermitted keys", %{schema: schema} do
      assert Parameter.prepare(%{id: "abc", limit: 10, abc: 1}, schema) == %{id: "abc", limit: 10, type: "user"}
    end

    test "cannot overwrite fixed value", %{schema: schema} do
      assert Parameter.prepare(%{type: "artist"}, schema) == %{type: "user"}
    end
  end

  describe "check_required!/2" do
    setup do
      %{schema: [{:id, required: true}, :limit, :offset, {:type, fixed: "user"}]}
    end

    test "raise if required parameter is missing", %{schema: schema} do
      assert_raise ArgumentError, fn ->
        Parameter.check_required!(%{limit: 10, abc: 1}, schema)
      end
    end

    test "does not raise when required parameter is given", %{schema: schema} do
      Parameter.check_required!(%{id: "abc", abc: 1}, schema)
    end
  end
end
