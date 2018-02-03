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

  @doc """
  Creates a modifier CSS class from the base class and a modifier atom.
  """
  def css_modifier(base, modifier) do
    "#{base}--#{dasherize(modifier)}"
  end

  @doc """
  Creates a dash-case version of a standard snake-case atom.
  """
  def dasherize(atom) when is_atom(atom) do
    atom
    |> to_string()
    |> String.replace("_", "-")
  end

  @doc """
  Creates the full CSS class from the base class and the modifiers if present in `options`.
  """
  def modified_css_class(base, modifiers, options) do
    modifier_classes =
      modifiers
      |> Enum.filter(fn(modifier) -> options[modifier] end)
      |> Enum.map(&(css_modifier(base, &1)))

    Enum.join([base | modifier_classes], " ")
  end

  @doc """
  Removes the given modifiers from the list of options.
  """
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
