defmodule PhoenixPrimerTest do
  use ExUnit.Case
  doctest PhoenixPrimer

  test "greets the world" do
    assert PhoenixPrimer.hello() == :world
  end
end
