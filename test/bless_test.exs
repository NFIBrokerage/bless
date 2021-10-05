defmodule BlessTest do
  use ExUnit.Case, async: true

  # excoveralls is not in the set of dependencies of this library in test mode
  test "the default bless suite doesn't include excoveralls" do
    refute Enum.any?(Bless.default(), fn {check, _args} ->
             check |> Atom.to_string() |> String.contains?("coveralls")
           end)
  end
end
