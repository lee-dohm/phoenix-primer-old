defmodule Primer.UtilitiesTest do
  use ExUnit.Case, async: true

  alias Primer.Utilities

  describe "css_class/1" do
    test "a module name as an atom" do
      assert Utilities.css_class(Test.FooBar) == "Foo-bar"
    end

    test "a module name as a binary" do
      assert Utilities.css_class("Test.FooBar") == "Foo-bar"
    end
  end

  describe "css_modifier/2" do
    test "a base css class and modifier" do
      assert Utilities.css_modifier("Base", :some_modifier) == "Base--some-modifier"
    end
  end

  describe "dasherize/1" do
    test "a name without underscores" do
      assert Utilities.dasherize(:foo) == "foo"
    end

    test "a name with underscores" do
      assert Utilities.dasherize(:foo_bar) == "foo-bar"
    end
  end
end
