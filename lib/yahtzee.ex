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

    two_and_five_case =
      Enum.member?(dices, 2) && Enum.member?(dices, 5) &&
        (!Enum.member?(dices, 1) || !Enum.member?(dices, 6))

    five_and_six_case =
      Enum.member?(dices, 5) && Enum.member?(dices, 6) &&
        (!Enum.member?(dices, 1) || !Enum.member?(dices, 2))

    one_and_two_case =
      Enum.member?(dices, 1) && Enum.member?(dices, 2) &&
        (!Enum.member?(dices, 5) || !Enum.member?(dices, 6))

    case(three_and_four && (two_and_five_case || five_and_six_case || one_and_two_case)) do
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

  def chance_check(dices) do
    three = !three_of_a_kind(dices)
    four = !four_of_a_kind(dices)
    house = !full_house(dices)
    small = !small_straight(dices)
    large = !large_straight(dices)
    yahtzee = !yahtzee(dices)

    chance = three && four && house && small && large && yahtzee

    case chance do
      true -> true
      _ -> false
    end
  end

  def three_of_a_kind(dices) do
    case length(
           Enum.filter(1..6, fn x ->
             length(Enum.filter(dices, fn e -> e == x end)) == 3
           end)
         ) == 1 do
      true -> true
      _ -> false
    end
  end

  def four_of_a_kind(dices) do
    case length(
           Enum.filter(1..6, fn x ->
             length(Enum.filter(dices, fn e -> e == x end)) == 4
           end)
         ) == 1 do
      true -> true
      _ -> false
    end
  end

  def full_house(dices) do
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
      true -> true
      _ -> false
    end
  end

  def yahtzee(dices) do
    case length(
           Enum.filter(1..6, fn x ->
             length(Enum.filter(dices, fn e -> e == x end)) == 5
           end)
         ) == 1 do
      true -> true
      _ -> false
    end
  end

  def score_lower(dices),
    do: %{
      "Three of a kind":
        case three_of_a_kind(dices) do
          true ->
            Enum.sum(dices)

          _ ->
            0
        end,
      "Four of a kind":
        case four_of_a_kind(dices) do
          true ->
            Enum.sum(dices)

          _ ->
            0
        end,
      "Full house":
        case full_house(dices) do
          true -> 25
          _ -> 0
        end,
      "Small straight":
        case !large_straight(dices) && small_straight(dices) do
          true -> 30
          _ -> 0
        end,
      "Large straight":
        case large_straight(dices) do
          true -> 40
          _ -> 0
        end,
      Yahtzee:
        case yahtzee(dices) do
          true -> 50
          _ -> 0
        end,
      Chance: Enum.sum(dices)
    }
end
