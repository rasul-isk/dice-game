defmodule YahtzeeUpperSectionTest do
  use ExUnit.Case

  test "works with 1 one" do
    assert %{Ones: 1} = Yahtzee.score_upper([1,2,3,4,5])
  end
  end
