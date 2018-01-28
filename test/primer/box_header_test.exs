defmodule Primer.BoxHeaderTest do
  use Primer.Case, async: true
  doctest Primer.BoxHeader

  alias Primer.BoxHeader

  test "generates a basic element" do
    assert render(%BoxHeader{}) == ~S{<div class="Box-header"></div>}
  end

  test "adding content" do
    assert render(%BoxHeader{content: "Test"}) == ~S{<div class="Box-header">Test</div>}
  end

  test "additional classes" do
    assert render(%BoxHeader{options: [class: "foo bar baz"]}) == ~S{<div class="Box-header foo bar baz"></div>}
  end

  test "other options" do
    assert render(%BoxHeader{options: [foo: "bar"]}) == ~S{<div class="Box-header" foo="bar"></div>}
  end
end
