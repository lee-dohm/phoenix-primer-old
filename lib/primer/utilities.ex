defmodule Primer.Utilities do
  @doc """
  Determines the Primer-style CSS class from the module.
  """
  def css_class(module) when is_atom(module) do
    module
    |> Module.split()
    |> do_css_class()
  end

  def css_class(module) when is_binary(module) do
    module
    |> String.split(".")
    |> do_css_class()
  end

  def css_class(module, modifiers, options) do
    modifier_classes =
      modifiers
      |> Enum.filter(fn(modifier) -> options[modifier] end)
      |> Enum.map(&(css_modifier(module, &1)))

    Enum.join([css_class(module) | modifier_classes], " ")
  end

  def css_modifier(module, modifier) do
    css_class(module) <> "--#{modifier}"
  end

  def strip_modifiers(options, modifiers) do
    Enum.reduce(modifiers, options, fn(modifier, options) -> Keyword.delete(options, modifier) end)
  end

  defp do_css_class(segments) do
    segments
    |> List.last()
    |> Macro.underscore()
    |> String.replace("_", "-")
    |> String.capitalize()
  end
end
