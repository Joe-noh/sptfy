defmodule Sptfy.Client.BodyMapperTest do
  use ExUnit.Case, async: true

  alias Sptfy.Client.BodyMapper

  describe "list_of/1" do
    test "returns a function which builds list of structs" do
      fun = BodyMapper.list_of(Sptfy.Object.AudioFeature)

      assert fun.([%{}]) == [%Sptfy.Object.AudioFeature{}]
      assert fun.([%{id: 10}]) == [%Sptfy.Object.AudioFeature{id: 10}]
      assert fun.([%{"id" => 10}]) == [%Sptfy.Object.AudioFeature{id: 10}]
    end
  end
end
