defmodule AocTest.Day1Test do
  use ExUnit.Case
  alias Aoc.Day1
  alias Aoc.Day2

  @tag :skip
  test "day 1 part1" do
    assert Day1.part1 == 439
  end

  @tag :skip
  @tag timeout: 99999999
  test "day 1 part2" do

    assert Day1.find_dupe(Stream.cycle([1, -1]), 0, 0, MapSet.new([0])) == 0
    assert Day1.find_dupe(Stream.cycle([3, 3, 4, -2, -4]), 0, 0, MapSet.new([0])) == 10
    assert Day1.find_dupe(Stream.cycle([-6, +3, +8, +5, -6]), 0, 0, MapSet.new([0])) == 5
    assert Day1.find_dupe(Stream.cycle([+7, +7, -2, -7, -4]), 0, 0, MapSet.new([0])) == 14
    assert Day1.part2 == 124645
  end

  @tag :skip
  test "day 2 part 1" do
    assert Day2.part1("day2_test") == 12
    assert Day2.part1("day2") == 8610
  end

  test "day 2 part 2" do
    assert Day2.part2_clean("day2_test2") == "fgij"
    assert Day2.part2_clean("day2") == "iosnxmfkpabcjpdywvrtahluy"
  end


end
