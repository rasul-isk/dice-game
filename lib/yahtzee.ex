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

  def small_straight(dices) do
    three_and_four = Enum.member?(dices, 3) && Enum.member?(dices, 4)
    two_and_five = Enum.member?(dices, 2) && Enum.member?(dices, 5)
    five_and_six = Enum.member?(dices, 5) && Enum.member?(dices, 6)
    one_and_two = Enum.member?(dices, 1) && Enum.member?(dices, 2)

    not_one_or_six = !Enum.member?(dices, 1) || !Enum.member?(dices, 6)
    not_one_or_two = !Enum.member?(dices, 1) || !Enum.member?(dices, 2)
    not_five_or_six = !Enum.member?(dices, 5) || !Enum.member?(dices, 6)

    case(
      (three_and_four &&
         (two_and_five &&
            not_one_or_six)) ||
        (five_and_six &&
           not_one_or_two) ||
        (one_and_two && not_five_or_six)
    ) do
      true -> true
      _ -> false
    end
  end

  def large_straight(dices) do
    three_and_four = Enum.member?(dices, 3) && Enum.member?(dices, 4)

    two_and_five_and_six =
      Enum.member?(dices, 2) && Enum.member?(dices, 5) && Enum.member?(dices, 6)

    one_and_two_and_five =
      Enum.member?(dices, 1) && Enum.member?(dices, 2) && Enum.member?(dices, 5)

    case(three_and_four && (two_and_five_and_six || one_and_two_and_five)) do
      true -> true
      _ -> false
    end
  end

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
        end,
      "Small straight":
        case small_straight(dices) do
          true -> 30
          _ -> -1
        end,
      "Large straight":
        case large_straight(dices) do
          true -> 40
          _ -> -1
        end
    }
end
