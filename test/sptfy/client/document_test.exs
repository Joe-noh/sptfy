defmodule Sptfy.Client.DocumentTest do
  use ExUnit.Case, async: true

  alias Sptfy.Client.Document

  describe "build/3" do
    test "includes HTTP method and path" do
      assert Document.build("GET", "/v1/path", []) |> String.contains?("GET /v1/path")
    end

    test "includes parameters' explanation" do
      doc = Document.build("GET", "/v1/path", [:id, :name])

      assert doc |> String.contains?("## Parameters")
      assert doc |> String.contains?("- `id`\n")
      assert doc |> String.contains?("- `name`\n")
    end

    test "does not mention fixed value parameter" do
      doc = Document.build("GET", "/v1/path", [:id, {:type, "fixed"}])

      assert doc |> String.contains?("## Parameters")
      assert doc |> String.contains?("- `id`\n")
      refute doc |> String.contains?("- `type`\n")
    end

    test "does not generate Parameter section when no parameter required" do
      refute Document.build("GET", "/v1/path", []) |> String.contains?("## Parameters")
    end
  end
end
