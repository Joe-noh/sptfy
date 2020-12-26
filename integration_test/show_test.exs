defmodule IntegrationTest.ShowTest do
  use ExUnit.Case

  alias Sptfy.Show
  alias Sptfy.Object.{FullShow, SimplifiedShow}

  setup_all do
    %{token: System.fetch_env!("SPOTIFY_TOKEN"), show_id: "38bS44xjbVVZ3No3ByF1dJ"}
  end

  test "get_shows/2", %{token: token, show_id: show_id} do
    assert {:ok, [%SimplifiedShow{}]} = Show.get_shows(token, ids: [show_id])
  end

  test "get_show/2", %{token: token, show_id: show_id} do
    assert {:ok, %FullShow{}} = Show.get_show(token, id: show_id, limit: 1)
  end
end
