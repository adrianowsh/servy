defmodule Servy.Conv do
  defstruct method: "", path: "", resp_body: "", params: %{}, headers: %{}, status: nil

  def full_status(%{status: status}), do: "#{status} #{status_reason(status)}"

  defp status_reason(code) do
    codes = %{
      200 => "Ok",
      201 => "Created",
      204 => "No Content",
      401 => "Unauthorized",
      403 => "FOrbidden",
      404 => "Not found",
      500 => "Internal Server Error"
    }

    codes[code]
  end
end
