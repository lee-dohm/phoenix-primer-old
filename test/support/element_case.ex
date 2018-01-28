defmodule Primer.ElementCase do
  defmacro __using__(options) do
    {module, options} = Keyword.pop(options, :module)

    options =
      options
      |> Keyword.update(:class, Primer.css_class(Macro.to_string(module)), &(&1))
      |> Keyword.update(:tag, :div, &(&1))

    quote do
      use Primer.Case, unquote(options)
      doctest unquote(module)

      @moduletag unquote(options)

      test "generates a basic element", %{class: class, tag: tag} do
        assert render(%unquote(module){}) == ~s{<#{tag} class="#{class}"></#{tag}>}
      end

      test "adding content", %{class: class, tag: tag} do
        assert render(%unquote(module){content: "Test"}) == ~s{<#{tag} class="#{class}">Test</#{tag}>}
      end

      test "additional classes", %{class: class, tag: tag} do
        assert render(%unquote(module){options: [class: "foo bar baz"]}) == ~s{<#{tag} class="#{class} foo bar baz"></#{tag}>}
      end

      test "other options", %{class: class, tag: tag} do
        assert render(%unquote(module){options: [foo: "bar"]}) == ~s{<#{tag} class="#{class}" foo="bar"></#{tag}>}
      end
    end
  end
end
