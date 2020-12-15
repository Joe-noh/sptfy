defmodule SptfyTest do
  use ExUnit.Case
  doctest Sptfy

  test "greets the world" do
    assert {:ok, %{status: 401}} = Sptfy.Track.get_audio_features("token", ids: [1,2,3])
  end
end
