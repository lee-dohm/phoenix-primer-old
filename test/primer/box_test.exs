defmodule Primer.BoxTest do
  use Primer.Case, async: true
  doctest Primer.Box

  alias Primer.Box

  test "generates a basic element" do
    assert render(%Box{}) == ~S{<div class="Box"></div>}
  end

  test "adding content" do
    assert render(%Box{content: "Test"}) == ~S{<div class="Box">Test</div>}
  end

  test "additional classes" do
    assert render(%Box{options: [class: "foo bar baz"]}) == ~S{<div class="Box foo bar baz"></div>}
  end

  test "other options" do
    assert render(%Box{options: [foo: "bar"]}) == ~S{<div class="Box" foo="bar"></div>}
  end
end
