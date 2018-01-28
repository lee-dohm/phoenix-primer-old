defmodule Primer.BoxTest do
  use Primer.ElementCase, module: Primer.Box

  describe "modifiers" do
    test "condensed" do
      assert render(%Primer.Box{options: [condensed: true]}) == ~s{<div class="Box Box--condensed"></div>}
    end

    test "spacious" do
      assert render(%Primer.Box{options: [spacious: true]}) == ~s{<div class="Box Box--spacious"></div>}
    end

    test "blue" do
      assert render(%Primer.Box{options: [blue: true]}) == ~s{<div class="Box Box--blue"></div>}
    end

    test "danger" do
      assert render(%Primer.Box{options: [danger: true]}) == ~s{<div class="Box Box--danger"></div>}
    end

    test "doesn't include other options in class" do
      assert render(%Primer.Box{options: [test: true]}) == ~s{<div class="Box" test="test"></div>}
    end
  end
end
