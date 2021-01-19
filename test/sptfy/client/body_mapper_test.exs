defmodule Sptfy.Client.BodyMapperTest do
  use ExUnit.Case, async: true

  alias Sptfy.Client.BodyMapper
  alias Sptfy.Object.{CursorPaging, Paging, SimplifiedArtist}

  describe "map/2 with :single tuple" do
    test "maps a json object to a struct" do
      mapping = {:single, module: SimplifiedArtist}

      assert BodyMapper.map(%{}, mapping) == {:ok, %SimplifiedArtist{}}
      assert BodyMapper.map(%{id: 10}, mapping) == {:ok, %SimplifiedArtist{id: 10}}
      assert BodyMapper.map(%{"id" => 10}, mapping) == {:ok, %SimplifiedArtist{id: 10}}
    end
  end

  describe "list_of/2" do
    test "maps a json array to list of structs" do
      mapping = BodyMapper.list_of(SimplifiedArtist, "key")

      assert BodyMapper.map(%{"key" => [%{}]}, mapping) == {:ok, [%SimplifiedArtist{}]}
      assert BodyMapper.map(%{"key" => [%{id: 10}]}, mapping) == {:ok, [%SimplifiedArtist{id: 10}]}
      assert BodyMapper.map(%{"key" => [%{"id" => 10}]}, mapping) == {:ok, [%SimplifiedArtist{id: 10}]}
    end

    test "handle list when key is nil" do
      mapping = BodyMapper.list_of(SimplifiedArtist)

      assert BodyMapper.map([nil, %{id: 10}, nil], mapping) == {:ok, [nil, %SimplifiedArtist{id: 10}, nil]}
    end

    test "maps nil into nil" do
      mapping = BodyMapper.list_of(SimplifiedArtist, "key")

      assert BodyMapper.map(%{"key" => [nil, %{id: 10}, nil]}, mapping) == {:ok, [nil, %SimplifiedArtist{id: 10}, nil]}
    end
  end

  describe "paged/2" do
    test "maps a json object to structs wrapped by Paging" do
      mapping = BodyMapper.paged(SimplifiedArtist)

      assert BodyMapper.map(%{"items" => []}, mapping) == {:ok, %Paging{items: []}}
      assert BodyMapper.map(%{"items" => [%{id: 10}]}, mapping) == {:ok, %Paging{items: [%SimplifiedArtist{id: 10}]}}
      assert BodyMapper.map(%{"items" => [%{"id" => 10}]}, mapping) == {:ok, %Paging{items: [%SimplifiedArtist{id: 10}]}}
    end
  end

  describe "cursor_paged/2" do
    test "maps a json object to structs wrapped by CursorPaging" do
      mapping = BodyMapper.cursor_paged(SimplifiedArtist)

      assert BodyMapper.map(%{"items" => []}, mapping) == {:ok, %CursorPaging{items: []}}
      assert BodyMapper.map(%{"items" => [%{id: 10}]}, mapping) == {:ok, %CursorPaging{items: [%SimplifiedArtist{id: 10}]}}
      assert BodyMapper.map(%{"items" => [%{"id" => 10}]}, mapping) == {:ok, %CursorPaging{items: [%SimplifiedArtist{id: 10}]}}
    end
  end

  describe "as_is/0" do
    test "returns given map" do
      mapping = BodyMapper.as_is()

      assert BodyMapper.map(%{}, mapping) == {:ok, %{}}
      assert BodyMapper.map(%{id: 10}, mapping) == {:ok, %{id: 10}}
      assert BodyMapper.map(%{"id" => 10}, mapping) == {:ok, %{"id" => 10}}
    end
  end
end
