defmodule Primer.ElementCase do
  defmacro __using__(options) do
    module_name = options[:module_name]

    quote do
      use Primer.Case, unquote(options)
      doctest unquote(module_name)

      @moduletag unquote(options)

      test "generates a basic element", %{class: class} do
        assert render(%unquote(module_name){}) == ~s{<div class="#{class}"></div>}
      end

      test "adding content", %{class: class} do
        assert render(%unquote(module_name){content: "Test"}) == ~s{<div class="#{class}">Test</div>}
      end

      test "additional classes", %{class: class} do
        assert render(%unquote(module_name){options: [class: "foo bar baz"]}) == ~s{<div class="#{class} foo bar baz"></div>}
      end

      test "other options", %{class: class} do
        assert render(%unquote(module_name){options: [foo: "bar"]}) == ~s{<div class="#{class}" foo="bar"></div>}
      end
    end
  end
end
