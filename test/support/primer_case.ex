defmodule Primer.Case do
  use ExUnit.CaseTemplate

  using do
    quote do
      import Primer.Support.Helpers
    end
  end
end
