defmodule Fixtures do
  def full_album do
    %{
      "album_type" => "compilation",
      "artists" => [simplified_artist()],
      "available_markets" => ["US"],
      "copyrights" => [%{"text" => "COPYRIGHTS", "type" => "C"}],
      "external_ids" => %{"upc" => "UPC"},
      "external_urls" => %{
        "spotify" => "https://open.spotify.com/album/ALBUM_ID"
      },
      "genres" => [],
      "href" => "https://api.spotify.com/v1/albums/ALBUM_ID",
      "id" => "ALBUM_ID",
      "images" => [image(), image(), image()],
      "label" => "LABEL",
      "name" => "ALBUM NAME",
      "popularity" => 42,
      "release_date" => "1995",
      "release_date_precision" => "year",
      "total_tracks" => 3,
      "tracks" => paging(simplified_track()),
      "type" => "album",
      "uri" => "spotify:album:ALBUM_ID"
    }
  end

  def simplified_album do
    %{
      "album_group" => "album",
      "album_type" => "album",
      "artists" => [simplified_artist()],
      "available_markets" => ["US"],
      "external_urls" => %{
        "spotify" => "https://open.spotify.com/album/ALBUM_ID"
      },
      "href" => "https://api.spotify.com/v1/albums/ALBUM_ID",
      "id" => "ALBUM_ID",
      "images" => [image(), image(), image()],
      "name" => "ALBUM NAME",
      "release_date" => "2007-10-23",
      "release_date_precision" => "day",
      "total_tracks" => 25,
      "type" => "album",
      "uri" => "spotify:album:ALBUM_ID"
    }
  end

  def full_artist do
    %{
      "external_urls" => %{
        "spotify" => "https://open.spotify.com/artist/ARTIST_ID"
      },
      "followers" => %{
        "href" => nil,
        "total" => 633_494
      },
      "genres" => ["art rock"],
      "href" => "https://api.spotify.com/v1/artists/ARTIST_ID",
      "id" => "ARTIST_ID",
      "images" => [image(), image(), image()],
      "name" => "ARTIST NAME",
      "popularity" => 77,
      "type" => "artist",
      "uri" => "spotify:artist:ARTIST_ID"
    }
  end

  def simplified_artist do
    %{
      "external_urls" => %{
        "spotify" => "https://open.spotify.com/artist/ARTIST_ID"
      },
      "href" => "https://api.spotify.com/v1/artists/ARTIST_ID",
      "id" => "ARTIST_ID",
      "name" => "ARTIST NAME",
      "type" => "artist",
      "uri" => "spotify:artist:ARTIST_ID"
    }
  end

  def audio_feature do
    %{
      "danceability" => 0.808,
      "energy" => 0.626,
      "key" => 7,
      "loudness" => -12.733,
      "mode" => 1,
      "speechiness" => 0.168,
      "acousticness" => 0.00187,
      "instrumentalness" => 0.159,
      "liveness" => 0.376,
      "valence" => 0.369,
      "tempo" => 123.99,
      "type" => "audio_features",
      "id" => "TRACK_ID",
      "uri" => "spotify:track:TRACK_ID",
      "track_href" => "https://api.spotify.com/v1/tracks/TRACK_ID",
      "analysis_url" => "http://echonest-analysis.s3.amazonaws.com/TR/.../full.json",
      "duration_ms" => 535_223,
      "time_signature" => 4
    }
  end

  def category do
    %{
      "href" => "https://api.spotify.com/v1/browse/categories/CATEGORY_ID",
      "icons" => [image()],
      "id" => "CATEGORY_ID",
      "name" => "CATEGORY NAME"
    }
  end

  def full_episode do
    %{
      "audio_preview_url" => "https://p.scdn.co/mp3-preview/...",
      "description" => "EPISODE DESCRIPTION",
      "duration_ms" => 1_502_795,
      "explicit" => false,
      "external_urls" => %{
        "spotify" => "https://open.spotify.com/episode/EPISODE_ID"
      },
      "href" => "https://api.spotify.com/v1/episodes/EPISODE_ID",
      "id" => "EPISODE_ID",
      "images" => [image(), image(), image()],
      "is_externally_hosted" => false,
      "is_playable" => true,
      "language" => "en",
      "languages" => ["en"],
      "name" => "EPISODE NAME",
      "release_date" => "2015-10-01",
      "release_date_precision" => "day",
      "resume_point" => %{"fully_played" => false, "resume_position_ms" => 0},
      "show" => simplified_show(),
      "type" => "episode",
      "uri" => "spotify:episode:EPISODE_ID"
    }
  end

  def simplified_episode do
    %{
      "audio_preview_url" => "https://p.scdn.co/mp3-preview/...",
      "description" => "EPISODE DESCRIPTION",
      "duration_ms" => 1_502_795,
      "explicit" => false,
      "external_urls" => %{
        "spotify" => "https://open.spotify.com/episode/EPISODE_ID"
      },
      "href" => "https://api.spotify.com/v1/episodes/EPISODE_ID",
      "id" => "EPISODE_ID",
      "images" => [image(), image(), image()],
      "is_externally_hosted" => false,
      "is_playable" => true,
      "language" => "en",
      "languages" => ["en"],
      "name" => "EPISODE NAME",
      "release_date" => "2015-10-01",
      "release_date_precision" => "day",
      "resume_point" => %{"fully_played" => false, "resume_position_ms" => 0},
      "type" => "episode",
      "uri" => "spotify:episode:EPISODE_ID"
    }
  end

  def image do
    %{
      "height" => 300,
      "url" => "https://i.scdn.co/image/...",
      "width" => 300
    }
  end

  def owner do
    %{
      "display_name" => "Spotify",
      "external_urls" => %{
        "spotify" => "https://open.spotify.com/user/USER_ID"
      },
      "href" => "https://api.spotify.com/v1/users/USER_ID",
      "id" => "USER_ID",
      "type" => "user",
      "uri" => "spotify:user:USER_ID"
    }
  end

  def full_playlist do
    %{
      "collaborative" => false,
      "description" => "PLAYLIST DESCRIPTION",
      "external_urls" => %{
        "spotify" => "https://open.spotify.com/playlist/PLAYLIST_ID"
      },
      "href" => "https://api.spotify.com/v1/playlists/PLAYLIST_ID",
      "id" => "PLAYLIST_ID",
      "images" => [image()],
      "name" => "PLAYLIST NAME",
      "owner" => owner(),
      "primary_color" => nil,
      "public" => true,
      "snapshot_id" => "SNAPSHOT_ID",
      "tracks" => %{
        "href" => "https://api.spotify.com/v1/playlists/PLAYLIST_ID/tracks",
        "total" => 50
      },
      "type" => "playlist",
      "uri" => "spotify:playlist:PLAYLIST_ID"
    }
  end

  def playlist_track do
    %{
      "added_at" => "2020-12-21T16:08:09Z",
      "added_by" => %{
        "external_urls" => %{"spotify" => "https://open.spotify.com/user/USER_ID"},
        "href" => "https://api.spotify.com/v1/users/USER_ID",
        "id" => "USER_ID",
        "type" => "user",
        "uri" => "spotify:user:USER_ID"
      },
      "is_local" => false,
      "primary_color" => nil,
      "track" => full_track()
    }
  end

  def private_profile do
    %{
      "country" => "US",
      "display_name" => "DISPLAY NAME",
      "email" => "email@example.com",
      "explicit_content" => %{"filter_enabled" => false, "filter_locked" => false},
      "external_urls" => %{
        "spotify" => "https://open.spotify.com/user/USER_ID"
      },
      "followers" => %{"href" => nil, "total" => 2},
      "href" => "https://api.spotify.com/v1/users/USER_ID",
      "id" => "USER_ID",
      "images" => [image()],
      "product" => "premium",
      "type" => "user",
      "uri" => "spotify:user:USER_ID"
    }
  end

  def public_profile do
    %{
      "display_name" => "DISPLAY NAME",
      "external_urls" => %{
        "spotify" => "https://open.spotify.com/user/USER_ID"
      },
      "followers" => %{"href" => nil, "total" => 2},
      "href" => "https://api.spotify.com/v1/users/USER_ID",
      "id" => "USER_ID",
      "images" => [image()],
      "type" => "user",
      "uri" => "spotify:user:USER_ID"
    }
  end

  def recommendation do
    %{
      "seeds" => [recommendation_seed()],
      "tracks" => [simplified_track()]
    }
  end

  def recommendation_seed do
    %{
      "afterFilteringSize" => 250,
      "afterRelinkingSize" => 250,
      "href" => "https://api.spotify.com/v1/artists/ARTIST_ID",
      "id" => "ARTIST_ID",
      "initialPoolSize" => 250,
      "type" => "ARTIST"
    }
  end

  def saved_album do
    %{
      "added_at" => "2020-12-21T16:08:09Z",
      "album" => full_album()
    }
  end

  def saved_track do
    %{
      "added_at" => "2020-12-21T16:08:09Z",
      "track" => full_track()
    }
  end

  def saved_show do
    %{
      "added_at" => "2020-12-21T16:08:09Z",
      "show" => simplified_show()
    }
  end

  def full_show do
    %{
      "available_markets" => ["US"],
      "copyrights" => [],
      "description" => "SHOW DESCRIPTION",
      "episodes" => paging(simplified_episode()),
      "explicit" => false,
      "external_urls" => %{
        "spotify" => "https://open.spotify.com/show/SHOW_ID"
      },
      "href" => "https://api.spotify.com/v1/shows/SHOW_ID",
      "id" => "SHOW_ID",
      "images" => [image(), image(), image()],
      "is_externally_hosted" => false,
      "languages" => ["en"],
      "media_type" => "audio",
      "name" => "SHOW NAME",
      "publisher" => "SHOW PUBLISHER",
      "total_episodes" => 500,
      "type" => "show",
      "uri" => "spotify:show:SHOW_ID"
    }
  end

  def simplified_show do
    %{
      "available_markets" => ["US"],
      "copyrights" => [],
      "description" => "SHOW DESCRIPTION",
      "explicit" => false,
      "external_urls" => %{
        "spotify" => "https://open.spotify.com/show/SHOW_ID"
      },
      "href" => "https://api.spotify.com/v1/shows/SHOW_ID",
      "id" => "SHOW_ID",
      "images" => [image(), image(), image()],
      "is_externally_hosted" => false,
      "languages" => ["en"],
      "media_type" => "audio",
      "name" => "SHOW NAME",
      "publisher" => "SHOW PUBLISHER",
      "total_episodes" => 500,
      "type" => "show",
      "uri" => "spotify:show:SHOW_ID"
    }
  end

  def full_track do
    %{
      "album" => %{
        "album_type" => "single",
        "artists" => [simplified_artist()],
        "available_markets" => ["US"],
        "external_urls" => %{
          "spotify" => "https://open.spotify.com/album/ALBUM_ID"
        },
        "href" => "https://api.spotify.com/v1/albums/ALBUM_ID",
        "id" => "ALBUM_ID",
        "images" => [image(), image(), image()],
        "name" => "ALBUM NAME",
        "release_date" => "2017-05-26",
        "release_date_precision" => "day",
        "type" => "album",
        "uri" => "spotify:album:ALBUM_ID"
      },
      "artists" => [simplified_artist()],
      "available_markets" => ["US"],
      "disc_number" => 1,
      "duration_ms" => 207_959,
      "explicit" => false,
      "external_ids" => %{
        "isrc" => "ISRC"
      },
      "external_urls" => %{
        "spotify" => "https://open.spotify.com/track/TRACK_ID"
      },
      "href" => "https://api.spotify.com/v1/tracks/TRACK_ID",
      "id" => "TRACK_ID",
      "is_local" => false,
      "name" => "TRACK NAME",
      "popularity" => 63,
      "preview_url" => "https://p.scdn.co/mp3-preview/...",
      "track_number" => 1,
      "type" => "track",
      "uri" => "spotify:track:TRACK_ID"
    }
  end

  def simplified_track do
    %{
      "artists" => [simplified_artist()],
      "available_markets" => ["US"],
      "disc_number" => 1,
      "duration_ms" => 1_055_933,
      "explicit" => false,
      "external_urls" => %{
        "spotify" => "https://open.spotify.com/track/TRACK_ID"
      },
      "href" => "https://api.spotify.com/v1/tracks/TRACK_ID",
      "id" => "TRACK_ID",
      "is_local" => false,
      "name" => "TRACK NAME",
      "preview_url" => "https://p.scdn.co/mp3-preview/...",
      "track_number" => 1,
      "type" => "track",
      "uri" => "spotify:track:TRACK_ID"
    }
  end

  def simplified_playlist do
    %{
      "collaborative" => false,
      "description" => "PLAYLIST DESCRIPTION",
      "external_urls" => %{
        "spotify" => "https://open.spotify.com/playlist/PLAYLIST_ID"
      },
      "href" => "https://api.spotify.com/v1/playlists/PLAYLIST_ID",
      "id" => "PLAYLIST_ID",
      "images" => [image()],
      "name" => "PLAYLIST NAME",
      "owner" => owner(),
      "primary_color" => nil,
      "public" => true,
      "snapshot_id" => "SNAPSHOT_ID",
      "tracks" => %{
        "href" => "https://api.spotify.com/v1/playlists/PLAYLIST_ID/tracks",
        "total" => 50
      },
      "type" => "playlist",
      "uri" => "spotify:playlist:PLAYLIST_ID"
    }
  end

  def paging(json) do
    %{
      "href" => "https://api.spotify.com/v1/...?offset=0&limit=50",
      "items" => [json],
      "limit" => 50,
      "next" => nil,
      "offset" => 0,
      "previous" => nil,
      "total" => 3
    }
  end
end
