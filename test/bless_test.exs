defmodule BlessTest do
  use ExUnit.Case, async: true

  # excoveralls is not in the set of dependencies of this library in test mode
  test "the default bless suite doesn't include excoveralls" do
    refute Enum.any?(Bless.default(), fn {check, _args} ->
             check |> Atom.to_string() |> String.contains?("coveralls")
           end)
  end

  describe "Bless.combine_args" do
    test "parent \"--seed\" argument is passed through to relevant tasks" do
      assert ["--seed", _val] =
               Bless.combine_args({:test, []}, [
                 "--seed",
                 "#{Enum.random(0..5000)}"
               ])

      assert ["--seed", _val] =
               Bless.combine_args({:"coveralls.html", []}, [
                 "--seed",
                 "#{Enum.random(0..5000)}"
               ])

      assert ["--seed", _val] =
               Bless.combine_args({:"chaps.html", []}, [
                 "--seed",
                 "#{Enum.random(0..5000)}"
               ])
    end

    test "parent \"--seed\" argument is not passed through to unrelated tasks" do
      assert [] =
               Bless.combine_args({:credo, []}, [
                 "--seed",
                 "#{Enum.random(0..5000)}"
               ])

      assert [] =
               Bless.combine_args({:"deps.unlock", []}, [
                 "--seed",
                 "#{Enum.random(0..5000)}"
               ])

      assert [] =
               Bless.combine_args({:compile, []}, [
                 "--seed",
                 "#{Enum.random(0..5000)}"
               ])
    end
  end
end
