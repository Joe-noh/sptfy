defmodule IntegrationTest.TrackTest do
  use ExUnit.Case

  alias Sptfy.Track

  setup_all do
    %{token: System.fetch_env!("SPOTIFY_TOKEN")}
  end

  test "get_track/2", %{token: token} do
    Track.get_track(token, id: "3n3Ppam7vgaVa1iaRUc9Lp") |> IO.inspect
  end
end
