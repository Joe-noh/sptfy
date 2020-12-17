defmodule Sptfy.Client.ResponseMapperTest do
  use ExUnit.Case, async: true

  alias Sptfy.Client.ResponseMapper

  describe "list_of/1" do
    test "returns a function which builds list of structs" do
      fun = ResponseMapper.list_of(Sptfy.Object.AudioFeature)

      assert fun.([%{}]) == [%Sptfy.Object.AudioFeature{}]
      assert fun.([%{id: 10}]) == [%Sptfy.Object.AudioFeature{id: 10}]
      assert fun.([%{"id" => 10}]) == [%Sptfy.Object.AudioFeature{id: 10}]
    end
  end
end
