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
end
