defmodule Aoc.Day5 do

  @alphabet ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]

  def part1 do
    input =
      File.read!("./input/day5")
      |> replace(0)
  end

  def replace(string, prev_len) do
    units =
      for(i <- @alphabet, do: [i <> String.upcase(i), String.upcase(i) <> i]) |> List.flatten()

    string =
      Enum.reduce(units, string, fn x, acc ->
        String.replace(acc, x, "")
      end)

    cond do
      String.length(string) == prev_len -> String.length(string)
      true -> replace(string, String.length(string))
    end
  end

  def part2 do
    input = File.read!("./input/day5")

    @alphabet
    |> Enum.map(fn x ->
        input
        |> String.replace(x, "")
        |> String.replace(String.upcase(x), "")
        |> replace(0)
    end)
    |> Enum.min()
  end
end
