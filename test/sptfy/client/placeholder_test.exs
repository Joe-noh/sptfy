defmodule Sptfy.Client.PlaceholderTest do
  use ExUnit.Case, async: true

  alias Sptfy.Client.Placeholder

  describe "extract/1" do
    test "extract placeholder names from string" do
      assert Placeholder.extract("/users/:id") == ~w[id]a
      assert Placeholder.extract("/users/:id/posts/:post_id") == ~w[id post_id]a
    end
  end

  describe "fill/2" do
    test "replace placeholders with given parameters" do
      assert Placeholder.fill("/users/:id", id: 1) == "/users/1"
      assert Placeholder.fill("/users/:id/posts/:post_id", id: 1, post_id: 2) == "/users/1/posts/2"
    end
  end
end
