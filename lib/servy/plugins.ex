defmodule Servy.Plugins do
  alias Servy.Conv

  def track(%Conv{status: 404, path: path} = conv) do
    IO.puts(~c"Warning: #{path} is on the loose")
    conv
  end

  def track(conv), do: conv

  def rewrite_path(%Conv{path: "wildlife"} = conv) do
    %Conv{conv | path: "/wildthings"}
  end

  def rewrite_path(conv), do: conv

  def log(conv), do: IO.inspect(conv)
end
