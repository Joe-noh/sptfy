defmodule IntegrationTest.FollowTest do
  use ExUnit.Case

  alias Sptfy.Follow
  alias Sptfy.Object.{FullArtist, Paging}

  setup_all do
    %{
      token: System.fetch_env!("SPOTIFY_TOKEN"),
      user_id: "spotify",
      playlist_id: "37i9dQZF1DX4sWSpwq3LiO",
      artist_id: "1g1nVvle9qO9AWIUWYvPAP"
    }
  end

  @tag skip: "has side effect"
  test "follow_playlist/2", %{token: token, playlist_id: playlist_id} do
    assert :ok = Follow.follow_playlist(token, id: playlist_id)
  end

  @tag skip: "has side effect"
  test "unfollow_playlist/2", %{token: token, playlist_id: playlist_id} do
    assert :ok = Follow.unfollow_playlist(token, id: playlist_id)
  end

  test "check_playlist_following_state/2", %{token: token, user_id: user_id, playlist_id: playlist_id} do
    assert {:ok, [true]} = Follow.check_playlist_following_state(token, id: playlist_id, ids: [user_id])
  end

  test "get_my_following_artists/2", %{token: token} do
    assert {:ok, %Paging{items: items}} = Follow.get_my_following_artists(token)
    assert Enum.all?(items, fn item -> %FullArtist{} = item end)
  end

  @tag skip: "has side effect"
  test "follow_users/2", %{token: token, user_id: user_id} do
    assert :ok = Follow.follow_users(token, ids: [user_id])
  end

  @tag skip: "has side effect"
  test "follow_artists/2", %{token: token, artist_id: artist_id} do
    assert :ok = Follow.follow_artists(token, ids: [artist_id])
  end

  @tag skip: "has side effect"
  test "unfollow_users/2", %{token: token, user_id: user_id} do
    assert :ok = Follow.unfollow_users(token, ids: [user_id])
  end

  @tag skip: "has side effect"
  test "unfollow_artists/2", %{token: token, artist_id: artist_id} do
    assert :ok = Follow.unfollow_artists(token, ids: [artist_id])
  end

  test "check_my_user_following_state/2", %{token: token, user_id: user_id} do
    assert {:ok, [false]} = Follow.check_my_user_following_state(token, ids: [user_id])
  end

  test "check_my_artist_following_state/2", %{token: token, artist_id: artist_id} do
    assert {:ok, [false]} = Follow.check_my_artist_following_state(token, ids: [artist_id])
  end
end

