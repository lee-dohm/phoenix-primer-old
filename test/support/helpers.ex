defmodule Primer.Support.Helpers do
  import Phoenix.HTML, only: [safe_to_string: 1]
  import Phoenix.HTML.Safe, only: [to_iodata: 1]

  def render(element) do
    element
    |> to_iodata()
    |> safe_to_string()
  end
end
