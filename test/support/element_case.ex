defmodule Primer.ElementCase do
  def css_class(module_name, nil) do
    module_name
    |> css_class(:unchanged)
    |> Macro.underscore()
    |> String.replace("_", "-")
    |> String.capitalize()
  end

  def css_class(module_name, :downcase) do
    module_name
    |> css_class(nil)
    |> String.downcase()
  end

  def css_class(module_name, :unchanged) do
    module_name
    |> String.split(".")
    |> List.last()
  end

  defmacro modifier_test(module, modifier) do
    quote do
      test "modifier :#{unquote(modifier)}" do
        class = unquote(module).class()
        tag = unquote(module).tag()
        rendered = render(%unquote(module){options: [{unquote(modifier), true}]})
        modifier = Primer.Utilities.dasherize(unquote(modifier))

        assert rendered == ~s{<#{tag} class="#{class} #{class}--#{modifier}"></#{tag}>}
      end
    end
  end

  defmacro __using__(options) do
    {module, options} = Keyword.pop(options, :module)
    class = css_class(Macro.to_string(module), options[:variant])

    options =
      options
      |> Keyword.update(:class, class, &(&1))
      |> Keyword.update(:tag, :div, &(&1))

    quote do
      use Primer.Case, unquote(options)
      doctest unquote(module)

      import Primer.ElementCase

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
