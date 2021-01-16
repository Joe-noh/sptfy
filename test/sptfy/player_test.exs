defmodule Sptfy.PlayerTest do
  use ExUnit.Case, async: false

  import Mock

  alias Sptfy.Player
  alias Sptfy.Object.{CurrentlyPlaying, CursorPaging, Device, Playback, PlayHistory}

  describe "get_playback/2" do
    test "returns a Playback struct" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me/player", _ -> MockHelpers.response(Fixtures.playback()) end do
        assert {:ok, %Playback{}} = Player.get_playback("token")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me/player", _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Player.get_playback("token")
      end
    end
  end

  describe "transfer_playback/2" do
    test "returns :ok" do
      with_mock Sptfy.Client.HTTP, put: fn _, "/v1/me/player", _, _ -> MockHelpers.response(%{}) end do
        assert :ok == Player.transfer_playback("token", device_ids: ["abc"])
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, put: fn _, "/v1/me/player", _, _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Player.transfer_playback("token", device_ids: ["abc"])
      end
    end
  end

  describe "get_devices/2" do
    test "returns a list of Device structs" do
      json = %{"devices" => [Fixtures.device()]}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me/player/devices", _ -> MockHelpers.response(json) end do
        assert {:ok, [%Device{}]} = Player.get_devices("token")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me/player/devices", _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Player.get_devices("token")
      end
    end
  end

  describe "get_currently_playing/2" do
    test "returns a CurrentlyPlaying struct" do
      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me/player/currently-playing", _ -> MockHelpers.response(Fixtures.currently_playing()) end do
        assert {:ok, %CurrentlyPlaying{}} = Player.get_currently_playing("token")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me/player/currently-playing", _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Player.get_currently_playing("token")
      end
    end
  end

  describe "play/2" do
    test "returns :ok" do
      with_mock Sptfy.Client.HTTP, put: fn _, "/v1/me/player/play", _, _ -> MockHelpers.response(%{}) end do
        assert :ok == Player.play("token")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, put: fn _, "/v1/me/player/play", _, _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Player.play("token")
      end
    end
  end

  describe "pause/2" do
    test "returns :ok" do
      with_mock Sptfy.Client.HTTP, put: fn _, "/v1/me/player/pause", _, _ -> MockHelpers.response(%{}) end do
        assert :ok == Player.pause("token")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, put: fn _, "/v1/me/player/pause", _, _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Player.pause("token")
      end
    end
  end

  describe "skip_to_next/2" do
    test "returns :ok" do
      with_mock Sptfy.Client.HTTP, post: fn _, "/v1/me/player/next", _, _ -> MockHelpers.response(%{}) end do
        assert :ok == Player.skip_to_next("token")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, post: fn _, "/v1/me/player/next", _, _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Player.skip_to_next("token")
      end
    end
  end

  describe "skip_to_prev/2" do
    test "returns :ok" do
      with_mock Sptfy.Client.HTTP, post: fn _, "/v1/me/player/previous", _, _ -> MockHelpers.response(%{}) end do
        assert :ok == Player.skip_to_prev("token")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, post: fn _, "/v1/me/player/previous", _, _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Player.skip_to_prev("token")
      end
    end
  end

  describe "seek/2" do
    test "returns :ok" do
      with_mock Sptfy.Client.HTTP, put: fn _, "/v1/me/player/seek", _, _ -> MockHelpers.response(%{}) end do
        assert :ok == Player.seek("token", position_ms: 30_000)
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, put: fn _, "/v1/me/player/seek", _, _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Player.seek("token", position_ms: 30_000)
      end
    end
  end

  describe "set_repeat/2" do
    test "returns :ok" do
      with_mock Sptfy.Client.HTTP, put: fn _, "/v1/me/player/repeat", _, _ -> MockHelpers.response(%{}) end do
        assert :ok == Player.set_repeat("token", state: "track")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, put: fn _, "/v1/me/player/repeat", _, _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Player.set_repeat("token", state: "track")
      end
    end
  end

  describe "set_volume/2" do
    test "returns :ok" do
      with_mock Sptfy.Client.HTTP, put: fn _, "/v1/me/player/volume", _, _ -> MockHelpers.response(%{}) end do
        assert :ok == Player.set_volume("token", volume_percent: 40)
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, put: fn _, "/v1/me/player/volume", _, _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Player.set_volume("token", volume_percent: 40)
      end
    end
  end

  describe "set_shuffle/2" do
    test "returns :ok" do
      with_mock Sptfy.Client.HTTP, put: fn _, "/v1/me/player/shuffle", _, _ -> MockHelpers.response(%{}) end do
        assert :ok == Player.set_shuffle("token", state: true)
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, put: fn _, "/v1/me/player/shuffle", _, _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Player.set_shuffle("token", state: true)
      end
    end
  end

  describe "get_recently_played/2" do
    test "returns a CursorPaging struct" do
      json = Fixtures.cursor_paging(Fixtures.play_history())

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me/player/recently-played", _ -> MockHelpers.response(json) end do
        assert {:ok, %CursorPaging{items: items}} = Player.get_recently_played("token")
        assert Enum.all?(items, fn item -> %PlayHistory{} = item end)
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, get: fn _, "/v1/me/player/recently-played", _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Player.get_recently_played("token")
      end
    end
  end

  describe "enqueue/2" do
    test "returns :ok" do
      with_mock Sptfy.Client.HTTP, post: fn _, "/v1/me/player/queue", _, _ -> MockHelpers.response(%{}) end do
        assert :ok == Player.enqueue("token", uri: "uri")
      end
    end

    test "returns Error struct on error" do
      json = %{"error" => %{"message" => "Oops", "status" => 401}}

      with_mock Sptfy.Client.HTTP, post: fn _, "/v1/me/player/queue", _, _ -> MockHelpers.response(json) end do
        assert {:error, %Sptfy.Object.Error{message: "Oops", status: 401}} = Player.enqueue("token", uri: "uri")
      end
    end
  end
end
