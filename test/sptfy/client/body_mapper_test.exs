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

  describe "map/2 with :list tuple" do
    test "maps a json array to list of structs" do
      mapping = {:list, module: SimplifiedArtist, key: "key"}

      assert BodyMapper.map(%{"key" => [%{}]}, mapping) == {:ok, [%SimplifiedArtist{}]}
      assert BodyMapper.map(%{"key" => [%{id: 10}]}, mapping) == {:ok, [%SimplifiedArtist{id: 10}]}
      assert BodyMapper.map(%{"key" => [%{"id" => 10}]}, mapping) == {:ok, [%SimplifiedArtist{id: 10}]}
    end

    test "handle list without key" do
      mapping = {:list, module: SimplifiedArtist}

      assert BodyMapper.map([nil, %{id: 10}, nil], mapping) == {:ok, [nil, %SimplifiedArtist{id: 10}, nil]}
    end

    test "maps nil into nil" do
      mapping = {:list, module: SimplifiedArtist, key: "key"}

      assert BodyMapper.map(%{"key" => [nil, %{id: 10}, nil]}, mapping) == {:ok, [nil, %SimplifiedArtist{id: 10}, nil]}
    end
  end

  describe "map/2 with :paging tuple" do
    test "maps a json object to structs wrapped by Paging" do
      mapping = {:paging, module: SimplifiedArtist, key: "key"}

      assert BodyMapper.map(%{"key" => %{"items" => []}}, mapping) == {:ok, %Paging{items: []}}
      assert BodyMapper.map(%{"key" => %{"items" => [%{id: 10}]}}, mapping) == {:ok, %Paging{items: [%SimplifiedArtist{id: 10}]}}
      assert BodyMapper.map(%{"key" => %{"items" => [%{"id" => 10}]}}, mapping) == {:ok, %Paging{items: [%SimplifiedArtist{id: 10}]}}
    end

    test "handle without key" do
      mapping = {:paging, module: SimplifiedArtist}

      assert BodyMapper.map(%{"items" => []}, mapping) == {:ok, %Paging{items: []}}
      assert BodyMapper.map(%{"items" => [%{id: 10}]}, mapping) == {:ok, %Paging{items: [%SimplifiedArtist{id: 10}]}}
      assert BodyMapper.map(%{"items" => [%{"id" => 10}]}, mapping) == {:ok, %Paging{items: [%SimplifiedArtist{id: 10}]}}
    end
  end

  describe "map/2 with :cursor_paging tuple" do
    test "maps a json object to structs wrapped by CursorPaging" do
      mapping = {:cursor_paging, module: SimplifiedArtist}

      assert BodyMapper.map(%{"items" => []}, mapping) == {:ok, %CursorPaging{items: []}}
      assert BodyMapper.map(%{"items" => [%{id: 10}]}, mapping) == {:ok, %CursorPaging{items: [%SimplifiedArtist{id: 10}]}}
      assert BodyMapper.map(%{"items" => [%{"id" => 10}]}, mapping) == {:ok, %CursorPaging{items: [%SimplifiedArtist{id: 10}]}}
    end
  end

  describe "map/2 with :as_is tuple" do
    test "returns given map" do
      mapping = {:as_is, key: "key"}

      assert BodyMapper.map(%{"key" => [true]}, mapping) == {:ok, [true]}
    end

    test "handle without key" do
      mapping = :as_is

      assert BodyMapper.map([true], mapping) == {:ok, [true]}
    end
  end

  describe "map/2 with :ok" do
    test "returns :ok" do
      mapping = :ok

      assert BodyMapper.map(%{}, mapping) == :ok
    end
  end
end
