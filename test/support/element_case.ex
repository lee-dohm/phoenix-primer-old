defmodule Primer.ElementCase do
  defmacro __using__(options) do
    module_name = options[:module_name]

    options =
      options
      |> Keyword.update(:tag, :div, &(&1))

    quote do
      use Primer.Case, unquote(options)
      doctest unquote(module_name)

      @moduletag unquote(options)

      test "generates a basic element", %{class: class, tag: tag} do
        assert render(%unquote(module_name){}) == ~s{<#{tag} class="#{class}"></#{tag}>}
      end

      test "adding content", %{class: class, tag: tag} do
        assert render(%unquote(module_name){content: "Test"}) == ~s{<#{tag} class="#{class}">Test</#{tag}>}
      end

      test "additional classes", %{class: class, tag: tag} do
        assert render(%unquote(module_name){options: [class: "foo bar baz"]}) == ~s{<#{tag} class="#{class} foo bar baz"></#{tag}>}
      end

      test "other options", %{class: class, tag: tag} do
        assert render(%unquote(module_name){options: [foo: "bar"]}) == ~s{<#{tag} class="#{class}" foo="bar"></#{tag}>}
      end
    end
  end
end
