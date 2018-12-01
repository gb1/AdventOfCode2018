defmodule Aoc.Day1 do
  alias Aoc.Utils

  def part1 do
    Utils.input_lines_into_list("day1")
    |> Enum.map(&String.to_integer(&1))
    |> Enum.sum()
  end

  def part2 do
    Utils.input_lines_into_list("day1")
    |> Enum.map(&String.to_integer(&1))
    |> Stream.cycle()
    |> find_dupe(0, 0, MapSet.new([0]))
  end

  def find_dupe(stream, index, curr_freq, freq_history) do
    next_freq = Enum.at(stream, index) + curr_freq

    cond do
      MapSet.member?(freq_history, next_freq) ->
        next_freq

      true ->
        find_dupe(stream, index + 1, next_freq, MapSet.put(freq_history, next_freq))
    end
  end
end
