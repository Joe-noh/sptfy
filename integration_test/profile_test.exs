defmodule IntegrationTest.ProfileTest do
  use ExUnit.Case

  alias Sptfy.Profile
  alias Sptfy.Object.{PrivateUser, PublicUser}

  setup_all do
    %{token: System.fetch_env!("SPOTIFY_TOKEN"), user_id: "spotify"}
  end

  test "get_my_profile/2", %{token: token} do
    assert {:ok, %PrivateUser{}} = Profile.get_my_profile(token)
  end

  test "get_profile/2", %{token: token, user_id: user_id} do
    assert {:ok, %PublicUser{}} = Profile.get_profile(token, id: user_id)
  end
end
