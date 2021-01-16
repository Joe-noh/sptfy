defmodule Sptfy.Player do
  use Sptfy.Client

  alias Sptfy.Object.{CurrentlyPlaying, Device, Paging, Playback, PlayHistory}

  get "/v1/me/player",
    as: :get_playback,
    query: [:market, :additional_types],
    mapping: single(Playback),
    return_type: {:ok, Playback.t()}

  put "/v1/me/player",
    as: :transfer_playback,
    query: [],
    body: [:device_ids, :play],
    mapping: ok(),
    return_type: :ok

  get "/v1/me/player/devices",
    as: :get_devices,
    query: [],
    mapping: list_of(Device, "devices"),
    return_type: {:ok, [Device.t()]}

  get "/v1/me/player/currently-playing",
    as: :get_currently_playing,
    query: [:market, :additional_types],
    mapping: single(CurrentlyPlaying),
    return_type: {:ok, CurrentlyPlaying.t()}

  put "/v1/me/player/play",
    as: :play,
    query: [:device_id],
    body: [:context_uri, :uris, :offset, :position_ms],
    mapping: ok(),
    return_type: :ok

  put "/v1/me/player/pause",
    as: :pause,
    query: [:device_id],
    body: [],
    mapping: ok(),
    return_type: :ok

  post "/v1/me/player/next",
    as: :skip_to_next,
    query: [:device_id],
    body: [],
    mapping: ok(),
    return_type: :ok

  post "/v1/me/player/previous",
    as: :skip_to_prev,
    query: [:device_id],
    body: [],
    mapping: ok(),
    return_type: :ok

  put "/v1/me/player/seek",
    as: :seek,
    query: [:position_ms, :device_id],
    body: [],
    mapping: ok(),
    return_type: :ok

  put "/v1/me/player/repeat",
    as: :set_repeat,
    query: [:state, :device_id],
    body: [],
    mapping: ok(),
    return_type: :ok

  put "/v1/me/player/volume",
    as: :set_volume,
    query: [:volume_percent, :device_id],
    body: [],
    mapping: ok(),
    return_type: :ok

  put "/v1/me/player/shuffle",
    as: :set_shuffle,
    query: [:state, :device_id],
    body: [],
    mapping: ok(),
    return_type: :ok

  get "/v1/me/player/recently-played",
    as: :get_recently_played,
    query: [:limit, :before, :after],
    mapping: cursor_paged(PlayHistory),
    return_type: {:ok, Paging.t()}

  post "/v1/me/player/queue",
    as: :enqueue,
    query: [:uri, :device_id],
    body: [],
    mapping: ok(),
    return_type: :ok
end
