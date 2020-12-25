defmodule Sptfy.Client.BodyMapperTest do
  use ExUnit.Case, async: true

  alias Sptfy.Client.BodyMapper
  alias Sptfy.Object.{Paging, SimplifiedArtist}

  describe "single/1" do
    test "maps a json object to a struct" do
      mapping = BodyMapper.single(SimplifiedArtist)

      assert BodyMapper.map(%{}, mapping) == %SimplifiedArtist{}
      assert BodyMapper.map(%{id: 10}, mapping) == %SimplifiedArtist{id: 10}
      assert BodyMapper.map(%{"id" => 10}, mapping) == %SimplifiedArtist{id: 10}
    end
  end

  describe "list_of/2" do
    test "maps a json array to list of structs" do
      mapping = BodyMapper.list_of(SimplifiedArtist, "key")

      assert BodyMapper.map(%{"key" => [%{}]}, mapping) == [%SimplifiedArtist{}]
      assert BodyMapper.map(%{"key" => [%{id: 10}]}, mapping) == [%SimplifiedArtist{id: 10}]
      assert BodyMapper.map(%{"key" => [%{"id" => 10}]}, mapping) == [%SimplifiedArtist{id: 10}]
    end
  end

  describe "paged/2" do
    test "maps a json object to structs wrapped by Paging" do
      mapping = BodyMapper.paged(SimplifiedArtist)

      assert BodyMapper.map(%{"items" => []}, mapping) == %Paging{items: []}
      assert BodyMapper.map(%{"items" => [%{id: 10}]}, mapping) == %Paging{items: [%SimplifiedArtist{id: 10}]}
      assert BodyMapper.map(%{"items" => [%{"id" => 10}]}, mapping) == %Paging{items: [%SimplifiedArtist{id: 10}]}
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
