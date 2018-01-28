defmodule Primer.BoxRowTest do
  use Primer.ElementCase, module: Primer.BoxRow

  describe "modifiers" do
    modifier_test Primer.BoxRow, :blue
    modifier_test Primer.BoxRow, :focus_blue
    modifier_test Primer.BoxRow, :focus_gray
    modifier_test Primer.BoxRow, :gray
    modifier_test Primer.BoxRow, :hover_blue
    modifier_test Primer.BoxRow, :hover_gray
    modifier_test Primer.BoxRow, :yellow
    modifier_test Primer.BoxRow, :unread
  end
end
