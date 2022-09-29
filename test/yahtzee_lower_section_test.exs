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

  test "Identify 'Four of a kind' with every face" do
    Enum.map(1..6, fn dice_face ->
      dices = generate(dice_face, 4)
      sum = Enum.sum(dices)
      assert %{"Four of a kind": ^sum} = Yahtzee.score_lower(dices)
    end)
  end

  test "Identify 'Full house' with every face" do
    Enum.map(1..6, fn _ ->
      [x, y] =
        Enum.shuffle(1..6)
        |> Enum.take(2)

      assert %{"Full house": 25} = Yahtzee.score_lower([x, x, x, y, y] |> Enum.shuffle())
    end)

    # custom test for not being "Full House" case
    assert %{"Full house": -1} = Yahtzee.score_lower([1, 2, 3, 4, 5] |> Enum.shuffle())
  end

  test "Small Straights check" do
    Enum.map(3, fn ->
      # Not possible cases for small straight
      assert %{"Small straight": -1} = Yahtzee.score_lower([1, 2, 5, 5, 6] |> Enum.shuffle())
      assert %{"Small straight": -1} = Yahtzee.score_lower([2, 2, 3, 4, 6] |> Enum.shuffle())
      assert %{"Small straight": -1} = Yahtzee.score_lower([1, 2, 3, 4, 5] |> Enum.shuffle())
      assert %{"Small straight": -1} = Yahtzee.score_lower([2, 3, 4, 5, 6] |> Enum.shuffle())

      # Possible cases for small straight
      assert %{"Small straight": 30} = Yahtzee.score_lower([5, 2, 3, 4, 3] |> Enum.shuffle())
      assert %{"Small straight": 30} = Yahtzee.score_lower([1, 3, 4, 5, 6] |> Enum.shuffle())
      assert %{"Small straight": 30} = Yahtzee.score_lower([3, 6, 4, 2, 1] |> Enum.shuffle())
    end)
  end
end
