defmodule IntegrationTest.PlayerTest do
  use ExUnit.Case

  alias Sptfy.Player
  alias Sptfy.Object.{CurrentlyPlaying, CursorPaging, Device, FullTrack, Playback, PlayHistory, UserQueue}

  setup_all do
    %{token: System.fetch_env!("SPOTIFY_TOKEN")}
  end

  test "get_playback/2", %{token: token} do
    assert {:ok, %Playback{}} = Player.get_playback(token)
  end

  @tag skip: "has side effect"
  test "transfer_playback/2", %{token: token} do
    {:ok, devices} = Player.get_devices(token)
    inactive = Enum.find(devices, fn device -> not device.is_active end)

    assert :ok == Player.transfer_playback(token, device_ids: [inactive.id], play: true)
  end

  test "get_devices/2", %{token: token} do
    assert {:ok, devices} = Player.get_devices(token)
    assert Enum.all?(devices, fn device -> %Device{} = device end)
  end

  test "get_currently_playing/2", %{token: token} do
    assert {:ok, %CurrentlyPlaying{}} = Player.get_currently_playing(token)
  end

  @tag skip: "has side effect"
  test "play/2", %{token: token} do
    assert :ok == Player.play(token)
  end

  @tag skip: "has side effect"
  test "pause/2", %{token: token} do
    assert :ok == Player.pause(token)
  end

  @tag skip: "has side effect"
  test "skip_to_next/2", %{token: token} do
    assert :ok == Player.skip_to_next(token)
  end

  @tag skip: "has side effect"
  test "skip_to_prev/2", %{token: token} do
    assert :ok == Player.skip_to_prev(token)
  end

  @tag skip: "has side effect"
  test "seek/2", %{token: token} do
    assert :ok == Player.seek(token, position_ms: 5000)
  end

  @tag skip: "has side effect"
  test "set_repeat/2", %{token: token} do
    assert :ok == Player.set_repeat(token, state: "track")
  end

  @tag skip: "has side effect"
  test "set_volume/2", %{token: token} do
    assert :ok == Player.set_volume(token, volume_percent: 10)
  end

  @tag skip: "has side effect"
  test "set_shuffle/2", %{token: token} do
    assert :ok == Player.set_shuffle(token, state: true)
  end

  test "get_recently_played/2", %{token: token} do
    assert {:ok, %CursorPaging{items: histories}} = Player.get_recently_played(token)
    assert Enum.all?(histories, fn history -> %PlayHistory{} = history end)
  end

  @tag skip: "has side effect"
  test "enqueue/2", %{token: token} do
    assert :ok == Player.enqueue(token, uri: "spotify:track:1t18idTmPA3sWLxYUWwesw")
  end

  test "get_user_queue/1", %{token: token} do
    assert {:ok, %UserQueue{currently_playing: currently_playing, queue: queue}} = Player.get_user_queue(token)
    assert %FullTrack{} = currently_playing
    assert Enum.all?(queue, fn item -> %FullTrack{} = item end)
  end
end
