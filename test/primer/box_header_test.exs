defmodule Primer.BoxHeaderTest do
  use Primer.ElementCase, module: Primer.BoxHeader

  describe "modifiers" do
    modifier_test Primer.BoxHeader, :blue
  end
end
