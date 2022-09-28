defmodule Yahtzee do
  def score_upper(dice) do
    %{Ones: length(Enum.filter(dice, fn e -> e == 1 end))}
  end
end
