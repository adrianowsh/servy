defmodule Servy.Parser do
  alias Servy.Conv, as: Conv

  def parse(request) do
    [mehtod, path, _] =
      request
      |> String.split("\n", trim: true)
      |> List.first()
      |> String.split(" ", trim: true)

    %Conv{
      method: mehtod,
      path: path
    }
  end
end
