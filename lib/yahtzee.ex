defmodule Yahtzee do
  def score_upper(dice),
    do: %{
      Ones: length(Enum.filter(dice, fn e -> e == 1 end)),
      Twos: length(Enum.filter(dice, fn e -> e == 2 end)),
      Threes: length(Enum.filter(dice, fn e -> e == 3 end)),
      Fours: length(Enum.filter(dice, fn e -> e == 4 end)),
      Fives: length(Enum.filter(dice, fn e -> e == 5 end)),
      Sixes: length(Enum.filter(dice, fn e -> e == 6 end))
    }

  def score_lower(dices),
    do: %{
      "Three of a kind":
        case length(
               Enum.filter(1..6, fn x ->
                 length(Enum.filter(dices, fn e -> e == x end)) == 3
               end)
             ) == 1 do
          true ->
            Enum.sum(dices)

          _ ->
            -1
        end,
      "Four of a kind":
        case length(
               Enum.filter(1..6, fn x ->
                 length(Enum.filter(dices, fn e -> e == x end)) == 4
               end)
             ) == 1 do
          true ->
            Enum.sum(dices)

          _ ->
            -1
        end,
      "Full house":
        case length(
               Enum.filter(1..6, fn x ->
                 length(Enum.filter(dices, fn e -> e == x end)) == 3
               end)
             ) == 1 &&
               length(
                 Enum.filter(1..6, fn x ->
                   length(Enum.filter(dices, fn e -> e == x end)) == 2
                 end)
               ) == 1 do
          true -> 25
          _ -> -1
        end
    }
end
