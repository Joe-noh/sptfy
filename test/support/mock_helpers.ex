defmodule MockHelpers do
  @moduledoc """
  Provides functions to help mocking API response.
  """

  def response(json) do
    body = json |> Jason.encode!()

    {:ok, %Finch.Response{body: body}}
  end
end
