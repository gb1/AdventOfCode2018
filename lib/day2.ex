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
    |> List.first
    |> String.replace("\r", "")

  end

  #rewrite with comprehensions!
  def part2_clean(file) do
    lines = Utils.input_lines_into_list(file)
    |> Enum.map( &String.graphemes(&1))

    for line <- lines do
      for compare <- lines do
        diffs =
        for {x,y} <- Enum.zip(line, compare) do
          cond do
          x != y -> line -- [x]
          true -> nil
          end
        end

        diffs
        |> Enum.filter(&(&1 != nil))
      end
      |> Enum.filter(&(length(&1) == 1))
      |> List.flatten
    end
    |> Enum.filter(&(length(&1) != 0))
    |> List.first
    |> to_string
    |> String.replace("\r", "")

  end

end
