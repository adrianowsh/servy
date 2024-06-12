defmodule Servy.Handler do
  @moduledoc """
   Handles HTTP Requests
  """

  import Servy.Plugins, only: [rewrite_path: 1, track: 1]
  import Servy.Parser, only: [parse: 1]
  import Servy.Router, only: [route: 1]

  alias Servy.Conv

  @doc """
  Transforms the requests into a response.
  """
  def handle(request) do
    request
    |> rewrite_path
    |> parse
    |> route
    |> track
    |> format_response
  end

  defp format_response(%Conv{resp_body: resp_body} = conv) do
    """
    HTTP/1.1 #{Conv.full_status(conv)}
    Content-Type: text/html
    Content-Length: #{byte_size(resp_body)}
    #{resp_body}
    """
  end
end
