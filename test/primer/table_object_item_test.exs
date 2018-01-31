defmodule Primer.TableObjectItemTest do
  use Primer.ElementCase, module: Primer.TableObjectItem, class: "TableObject-item"

  describe "modifiers" do
    modifier_test Primer.TableObjectItem, :primary
  end
end
