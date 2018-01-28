defmodule Primer.BoxTest do
  use Primer.ElementCase, module: Primer.Box

  describe "modifiers" do
    modifier_test Primer.Box, :condensed
    modifier_test Primer.Box, :spacious
    modifier_test Primer.Box, :blue
    modifier_test Primer.Box, :danger
  end
end
