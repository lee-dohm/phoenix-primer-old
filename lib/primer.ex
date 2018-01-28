defmodule Primer do
  @moduledoc """
  Primer is a set of helper functions, data structures and utilities to make working with [GitHub's
  Primer CSS framework](https://primer.github.io) simple.
  """
  import Phoenix.HTML.Safe, only: [to_iodata: 1]

  elements = [
    Primer.Box,
    Primer.BoxHeader
  ]

  Enum.each(elements, fn(element) ->
    fn_name =
      element
      |> Module.split()
      |> List.last()
      |> Macro.underscore()
      |> String.to_atom()

    module_text =
      element
      |> Module.split()
      |> Enum.join(".")

    @doc """
    Renders a `#{module_text}` element.
    """
    def unquote(fn_name)(content)

    def unquote(fn_name)([do: block]) do
      unquote(fn_name)(block, [])
    end

    def unquote(fn_name)(content) do
      unquote(fn_name)(content, [])
    end

    @doc """
    Renders a `#{module_text}` element.
    """
    def unquote(fn_name)(content, options)

    def unquote(fn_name)(options, [do: block]) when is_list(options) do
      unquote(fn_name)(block, options)
    end

    def unquote(fn_name)(content, options) when is_list(options) do
      to_iodata(%unquote(element){content: content, options: options})
    end

    defimpl Phoenix.HTML.Safe, for: element do
      def to_iodata(%unquote(element){} = el) do
        unquote(element).render(el)
      end
    end
  end)
end
