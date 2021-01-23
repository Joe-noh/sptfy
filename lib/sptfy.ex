defmodule Sptfy do
  @moduledoc """
  Sptfy is a [Spotify API](https://developer.spotify.com/documentation/web-api/) client library.

  ### Request resources

  Sptfy provides several API modules. For instance using `Sptfy.Album`, you can fetch an album.

      iex> {:ok, album = %Sptfy.Object.FullAlbum{}} = Sptfy.Album.get_album(access_token, id: "0ETFjACtuP2ADo6LFhL6HN")
      iex> album.name
      ...> "Abbey Road (Remastered)"

  Or get an error.

      iex> Sptfy.Album.get_album("abc", id: "...")
      ...> {:error, %Sptfy.Object.Error{message: "Invalid access token", status: 401}}

  More examples found on [`integration_test` dir](https://github.com/Joe-noh/sptfy/tree/main/integration_test).

  ### Obtain access token

  `Sptfy.OAuth` module supports authorization code flow.

      iex>  Sptfy.OAuth.url("CLIENT_ID", "https://example.com/callback", %{scope: ["user-top-read"]})
      ...> "https://accounts.spotify.com/authorize?client_id=..."

      iex> Sptfy.OAuth.get_token("CLIENT_ID", "CLIENT_SECRET", "CODE", "https://example.com/callback")
      ...> %Sptfy.Object.OAuthResponse{access_token: "ACCESS_TOKEN", refresh_token: "REFRESH_TOKEN"}

  You can request new access token using `Sptfy.OAuth.refresh_token/3` when it expired.

      iex> Sptfy.OAuth.refresh_token("CLIENT_ID", "CLIENT_SECRET", "REFRESH_TOKEN")
      ...> %Sptfy.Object.OAuthResponse{access_token: "NEW ACCESS_TOKEN"}
  """
end
