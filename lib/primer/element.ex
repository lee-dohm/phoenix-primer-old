defmodule Primer.Element do
  @moduledoc """
  A module to make it easy to define new structure types that will render themselves within Phoenix
  templates.

  ## Examples

  ```
  # defmodule Primer.Foo do
  #   use Primer.Element
  # end
  #
  iex> Phoenix.HTML.safe_to_string(%Primer.Foo{})
  "<div class=\"Foo\"></div>"
  iex> Phoenix.HTML.safe_to_string(%Primer.Foo{options: [class: "test"]})
  "<div class=\"Foo test\"></div>"
  iex> Phoenix.HTML.safe_to_string(%Primer.Foo{ontent: "Content", options: [class: "test"]})
  "<div class=\"Foo test\">Content</div>"
  ```
  """
  defmacro __using__(options) do
    tag = options[:tag] || :div

    quote do
      last_module_segment =
        __MODULE__
        |> Module.split()
        |> List.last()

      class =
        last_module_segment
        |> Macro.underscore()
        |> String.replace("_", "-")
        |> String.capitalize()

      @class Primer.Utilities.css_class(__MODULE__)
      @module_name_text __MODULE__ |> Module.split() |> Enum.join(".")

      use Phoenix.HTML

      @type t :: %__MODULE__{content: Phoenix.HTML.unsafe(), options: Keyword.t()}
      defstruct(content: [], options: [])

      @doc """
      Returns the framework CSS class to use to decorate this element.

      Class: `#{@class}`
      """
      @spec class :: String.t()
      def class, do: @class

      @doc """
      Returns the HTML tag the framework expects for this element.

      Tag: `#{unquote(tag)}`
      """
      @spec tag :: atom()
      def tag, do: unquote(tag)

      @doc """
      Renders the `#{@module_name_text}` structure to a
      [Phoenix safe text string.](https://hexdocs.pm/phoenix_html/Phoenix.HTML.html#module-html-safe)
      """
      @spec render(__MODULE__.t()) :: Phoenix.HTML.safe()
      def render(%__MODULE__{} = element) do
        options = Keyword.update(element.options, :class, class(), &(class() <> " " <> &1))

        content_tag tag(), element.content, options
      end

      defoverridable [class: 0, render: 1, tag: 0]
    end
  end
end
