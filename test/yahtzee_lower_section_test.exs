defmodule YahtzeeLowerSectionTest do
  use ExUnit.Case

  def generate(dice_face, occurrences) do
    Enum.to_list(1..6)
    |> List.delete(dice_face)
    |> Enum.shuffle()
    |> Enum.take(5 - occurrences)
    |> Enum.concat(List.duplicate(dice_face, occurrences))
    |> Enum.shuffle()
  end

  test "Identify 'Three of a kind' with ones" do
    dices = generate(1, 3)
    IO.inspect(dices)
    sum = Enum.sum(dices)
    assert %{"Three of a kind": ^sum} = Yahtzee.score_lower(dices)
  end

  test "Identify 'Three of a kind' with all the others" do
    Enum.map(2..6, fn dice_face ->
      dices = generate(dice_face, 3)
      sum = Enum.sum(dices)
      assert %{"Three of a kind": ^sum} = Yahtzee.score_lower(dices)
    end)
  end
end
