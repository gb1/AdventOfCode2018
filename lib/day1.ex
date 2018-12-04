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
    # |> find_dupe(0, 0, MapSet.new([0]))
    |> reduce
  end

  def find_dupe(stream, index, curr_freq, freq_history) do
    #!!! Enum.at is not lazy!!!!
    next_freq = Enum.at(stream, index) + curr_freq

    if next_freq in freq_history do
      next_freq
    else
      find_dupe(stream, index + 1, next_freq, MapSet.put(freq_history, next_freq))
    end
  end

  def reduce(stream) do
    stream
    |> Enum.reduce_while({0, MapSet.new([0])}, fn x, {current_frequency, seen_frequencies} ->
      new_frequency = current_frequency + x

      if new_frequency in seen_frequencies do
        {:halt, new_frequency}
      else
        {:cont, {new_frequency, MapSet.put(seen_frequencies, new_frequency)}}
      end
    end)
  end
end
