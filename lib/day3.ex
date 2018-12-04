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
    |> Enum.reduce(Matrex.new(1000, 1000, fn -> 0 end), fn {id, {pos_x, pos_y}, {dim_x, dim_y}},
                                                           acc ->
      Matrex.add(acc, create_matrix(id, {pos_x, pos_y}, {dim_x, dim_y}))
    end)
    |> Matrex.to_list()
    |> Enum.filter(&(&1 >= 2))
    |> length
  end

  def part2(file) do
    input =
      Utils.input_lines_into_list(file)
      |> Enum.map(fn line ->
        [id, at, pos, dims] = String.split(line, " ")
        [pos_x, pos_y] = pos |> String.replace(":", "") |> String.split(",")
        [dim_x, dim_y] = String.split(dims, "x")

        {id, {String.to_integer(pos_x), String.to_integer(pos_y)},
         {String.to_integer(dim_x), String.to_integer(dim_y)}}
      end)

    matrices =
      input
      |> Enum.map(fn {id, {pos_x, pos_y}, {dim_x, dim_y}} ->
        create_matrix(id, {pos_x, pos_y}, {dim_x, dim_y})
      end)

    final_matrix =
      matrices
      |> Enum.reduce(Matrex.new(1000, 1000, fn -> 0 end), fn x, acc ->
        Matrex.add(acc, x)
      end)

    Matrex.to_list(final_matrix)
    |> Enum.filter(&(&1 != 0))

    input
    |> Enum.reduce_while("", fn({id, {pos_x, pos_y}, {dim_x, dim_y}}, acc) ->
      #get the area from the final matrix and check if it's all 1's
      IO.puts "checking: " <> id
      m = Matrex.submatrix(final_matrix, pos_y+1..pos_y+dim_y, pos_x+1..pos_x+dim_x )
      IO.inspect Matrex.to_list(m)
      case Enum.all?(Matrex.to_list(m), fn(x) -> x == 1 end) do
        true -> {:halt, id}
        false -> {:cont, id}
      end
    end)
  end

  def create_matrix(id, {pos_x, pos_y}, {dim_x, dim_y}) do
    size = 1000

    IO.puts("creating matrix for id: " <> id)

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
