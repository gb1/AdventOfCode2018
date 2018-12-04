defmodule Aoc.Day3 do
  alias Aoc.Utils

  def part1(file) do
    Utils.input_lines_into_list(file)
    |> Enum.map(fn line ->
      [id, at, pos, dims] = String.split(line, " ")
      [pos_x, pos_y] = pos |> String.replace(":", "") |> String.split(",")
      [dim_x, dim_y] = String.split(dims, "x")

      {id, {String.to_integer(pos_x), String.to_integer(pos_y)},
       {String.to_integer(dim_x), String.to_integer(dim_y)}}
    end)
    |> Enum.map( fn({id, {pos_x, pos_y}, {dim_x, dim_y}})->
      create_matrix(id, {pos_x, pos_y}, {dim_x, dim_y})
    end)
    |> Enum.reduce(Matrex.new(1000,1000, fn -> 0 end), fn(x, acc) ->
      Matrex.add(acc, x)
    end)
    |> Matrex.to_list
    |> Enum.filter( &(&1 >= 2))
    |> length

  end

  def part2(file) do
    Utils.input_lines_into_list(file)
    |> Enum.map(fn line ->
      [id, at, pos, dims] = String.split(line, " ")
      [pos_x, pos_y] = pos |> String.replace(":", "") |> String.split(",")
      [dim_x, dim_y] = String.split(dims, "x")

      {id, {String.to_integer(pos_x), String.to_integer(pos_y)},
       {String.to_integer(dim_x), String.to_integer(dim_y)}}
    end)
    |> Enum.map( fn({id, {pos_x, pos_y}, {dim_x, dim_y}})->
      create_matrix(id, {pos_x, pos_y}, {dim_x, dim_y})
    end)
    |> Enum.reduce(Matrex.new(1000,1000, fn -> 0 end), fn(x, acc) ->
      Matrex.add(acc, x)
    end)
    |> Matrex.find(1)

  end

  def create_matrix(id, {pos_x, pos_y}, {dim_x, dim_y}) do
    size = 1000
    IO.puts("creating matrix for id: " <> id )
    matrix =
      for row <- 1..size do
        if row <= pos_y || row > pos_y + dim_y do
          for i <- 1..size, do: 0
        else
          for line <- 1..size do
            if line > pos_x && line <= pos_x + dim_x do
              1
            else
              0
            end
          end
        end
      end

    Matrex.new(matrix)
  end
end
