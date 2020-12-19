defmodule Sptfy.Client.BodyMapperTest do
  use ExUnit.Case, async: true

  alias Sptfy.Client.BodyMapper
  alias Sptfy.Object.Artist

  describe "single/1" do
    test "maps a json object to a struct" do
      mapping = BodyMapper.single(Artist)

      assert BodyMapper.map(%{}, mapping) == %Artist{}
      assert BodyMapper.map(%{id: 10}, mapping) == %Artist{id: 10}
      assert BodyMapper.map(%{"id" => 10}, mapping) == %Artist{id: 10}
    end
  end

  describe "list_of/2" do
    test "maps a json array to list of structs" do
      mapping = BodyMapper.list_of(Artist, "key")

      assert BodyMapper.map(%{"key" => [%{}]}, mapping) == [%Artist{}]
      assert BodyMapper.map(%{"key" => [%{id: 10}]}, mapping) == [%Artist{id: 10}]
      assert BodyMapper.map(%{"key" => [%{"id" => 10}]}, mapping) == [%Artist{id: 10}]
    end
  end

  describe "as_is/0" do
    test "returns given map" do
      mapping = BodyMapper.as_is()

      assert BodyMapper.map(%{}, mapping) == %{}
      assert BodyMapper.map(%{id: 10}, mapping) == %{id: 10}
      assert BodyMapper.map(%{"id" => 10}, mapping) == %{"id" => 10}
    end
  end
end
