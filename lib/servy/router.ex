defmodule Servy.Router do
  alias Servy.Conv

  @pages_path Path.expand("../page", __DIR__)

  def route(%Conv{method: "GET", path: "/wildthings"} = conv) do
    %Conv{conv | status: 200, resp_body: "Bears, Lions, Tigers"}
  end

  def route(%Conv{method: "GET", path: "/bears"} = conv) do
    %Conv{conv | status: 200, resp_body: "Teddy, Smokey, Paddington"}
  end

  def route(%Conv{method: "GET", path: "/bears" <> id} = conv) do
    %Conv{conv | status: 200, resp_body: "Bear #{id}"}
  end

  def route(%Conv{method: "POST", path: "/bears" = conv}) do
    %Conv{conv | status: 201, resp_body: "Bear #{id}"}
  end

  def route(%Conv{method: "GET", path: "/about"} = conv) do
    _ =
      @pages_path
      |> Path.join("about.html")
      |> File.read()
      |> handle_file(conv)
  end

  def route(%Conv{method: "DELETE", path: "/bear" <> _id} = conv) do
    %Conv{conv | status: 403, resp_body: "Deleting a bear is forbidden"}
  end

  def route(%{path: path} = conv) do
    %Conv{conv | resp_body: "No #{path} here!", status: 404}
  end

  defp handle_file({:ok, content}, conv),
    do: %Conv{conv | status: 200, resp_body: content}

  defp handle_file({:error, :enoent}, conv),
    do: %Conv{conv | status: 404, resp_body: "File not found"}

  defp handle_file({:error, reason}, conv),
    do: %Conv{conv | status: 500, resp_body: "File error #{reason}"}
end
