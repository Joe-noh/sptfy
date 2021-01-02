defmodule Sptfy.Profile do
  use Sptfy.Client

  alias Sptfy.Object.{PrivateUser, PublicUser}

  get "/v1/me",
    as: :get_my_profile,
    query: [],
    mapping: single(PrivateUser),
    return_type: {:ok, PrivateUser.t()}

  get "/v1/users/:id",
    as: :get_profile,
    query: [],
    mapping: single(PublicUser),
    return_type: {:ok, PublicUser.t()}
end
