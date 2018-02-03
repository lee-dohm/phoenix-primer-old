defmodule Primer.Element do
  @moduledoc """
  A module to make it easy to define new structure types that will render themselves within Phoenix
  templates.

  A module that uses `Element` will have a struct with `content` and `options` members, and three
  overridable functions:

  * `class/0` -- Returns the CSS class used to indicate an element of this type
  * `render/1` -- Renders the element based on the struct passed into it
  * `tag/0` -- Returns the HTML tag to use to render this element (defaults to `div`)

  ## Rendering

  The default render function accepts a structure belonging to its module and returns the rendered
  element based on the values in the structure. The basic element is formed by taking the output of
  the `class/0` and `tag/0` functions, and the `content` field of the structure to create this:

  ```html
  <tag class="class">content</tag>
  ```

  So if we were to have a module that looks like this:

  ```
  defmodule Test.ModuleName do
    use Primer.Element
  end
  ```

  Then the default `render/1` function with an empty `Test.ModuleName` struct would output:

  ```html
  <div class="Module-name"></div>
  ```

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
    class = options[:class]
    tag = options[:tag] || :div
    modifiers = options[:modifiers] || []

    quote do
      use Phoenix.HTML

      alias Primer.Utilities

      @class unquote(class) || Utilities.css_class(__MODULE__)
      @module_name_text __MODULE__ |> Module.split() |> Enum.join(".")

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
        class = Utilities.modified_css_class(__MODULE__.class(), unquote(modifiers), element.options)

        options =
          element.options
          |> Utilities.strip_modifiers(unquote(modifiers))
          |> Keyword.update(:class, class, &(class <> " " <> &1))

        content_tag tag(), element.content, options
      end

      def modifiers, do: unquote(modifiers)

      defoverridable [class: 0, render: 1, tag: 0]
    end
  end
end
