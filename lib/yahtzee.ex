defmodule Yahtzee do
  def score_upper(dice), do: %{
    Ones: length(Enum.filter(dice, fn e -> e == 1 end)),
    Twos: length(Enum.filter(dice, fn e -> e == 2 end))
}

end
