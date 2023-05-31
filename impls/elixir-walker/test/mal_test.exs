defmodule MALTest do
  use ExUnit.Case
  doctest MAL

  test "greets the world" do
    assert MAL.hello() == :world
  end
end
