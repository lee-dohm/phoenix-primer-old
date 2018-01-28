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
  defmacro __using__(_options) do
    quote do
      @class __MODULE__ |> Module.split() |> List.last()
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
      Returns the HTML tag name the framework expects for this element.

      Tag name: `:div`
      """
      @spec tag_name :: atom()
      def tag_name, do: :div

      @doc """
      Renders the `#{@module_name_text}` structure to a
      [Phoenix safe text string.](https://hexdocs.pm/phoenix_html/Phoenix.HTML.html#module-html-safe)
      """
      @spec render(__MODULE__.t()) :: Phoenix.HTML.safe()
      def render(%__MODULE__{} = element) do
        options = Keyword.update(element.options, :class, class(), &(class() <> " " <> &1))

        content_tag tag_name(), element.content, options
      end

      defoverridable [class: 0, render: 1, tag_name: 0]
    end
  end
end
