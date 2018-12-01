defmodule AocTest.Day1Test do
  use ExUnit.Case
  alias Aoc.Day1

  test "part1" do
    assert Day1.part1 == 439
  end

  @tag timeout: 99999999
  test "part2" do

    assert Day1.find_dupe(Stream.cycle([1, -1]), 0, 0, MapSet.new([0])) == 0
    assert Day1.find_dupe(Stream.cycle([3, 3, 4, -2, -4]), 0, 0, MapSet.new([0])) == 10
    assert Day1.find_dupe(Stream.cycle([-6, +3, +8, +5, -6]), 0, 0, MapSet.new([0])) == 5
    assert Day1.find_dupe(Stream.cycle([+7, +7, -2, -7, -4]), 0, 0, MapSet.new([0])) == 14
    assert Day1.part2 == 10
  end
end
