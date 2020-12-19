ExUnit.start()

defmodule TestHelpers do
  def response(json) do
    body = json |> Jason.encode!()

    {:ok, %Finch.Response{body: body}}
  end
end
