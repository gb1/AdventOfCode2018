defmodule Aoc.Day2 do
  alias Aoc.Utils

  def part1(file) do
    counts = Utils.input_lines_into_list(file)
    #split into letters & create a map of letters => letter counts
    |> Enum.map( fn(line) ->
    String.graphemes(line)
    |> Enum.reduce(%{}, fn(letter, acc) ->
      Map.update(acc, letter, 1, &(&1 + 1))
      end)
    end)

    doubles = counts
    |> Enum.map( fn(line) ->
      line |> Enum.filter( fn({_k, v}) ->
        v == 2
      end)
    end)
    |> Enum.filter( &(&1 != []))
    |> length

    triples = counts
    |> Enum.map( fn(line) ->
      line |> Enum.filter( fn({_k, v}) ->
        v == 3
      end)
    end)
    |> Enum.filter( &(&1 != []))
    |> length

    doubles * triples

  end

  def part2(file) do
    lines = Utils.input_lines_into_list(file)
    |> Enum.map( &String.graphemes(&1))

    lines |> Enum.map( fn(line) ->

      {line, lines
      |> Enum.map( &(line -- &1))
      |> Enum.filter(&(length(&1) == 1))}
    end)
    |> Enum.filter(&(elem(&1, 1) != []))
    |> Enum.map( &( ( elem(&1, 0) -- List.flatten(elem(&1, 1))) |> to_string ) )
    |> Enum.uniq

   # Enum.at(Enum.at(matches, 0), 0) -- Enum.at(Enum.at(Enum.at(matches, 1), 1), 0)
   # |> to_string() |> String.replace("\r", "")


  end

end
