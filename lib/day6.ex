defmodule Aoc.Day6 do
  alias Aoc.Utils

  @grid_size 400

  def part1(file) do
    grid =
      file
      |> Utils.input_lines_into_list()
      |> Enum.map(fn line ->
        [x, y] = String.split(line, ", ")
        {String.to_integer(x), String.to_integer(y)}
      end)
      |> build_grid

    totals =
      grid
      |> Enum.reduce(%{}, fn {k, v}, acc ->
        Map.update(acc, v, [k], &(&1 ++ [k]))
      end)
      |> Enum.map(fn {k, v} -> {k, length(v) + 1} end)

    infinites =
      grid
      |> Enum.reduce([], fn {k, v}, acc ->
        if 0 in Tuple.to_list(k) || @grid_size in Tuple.to_list(k) do
          acc ++ [v]
        else
          acc
        end
      end)
      |> Enum.uniq()

    totals
    |> Enum.filter(fn {point, value} ->
      point not in infinites
    end)
    |> Enum.sort_by(fn {point, value} -> value end)
    |> List.last()
  end

  def manhattan({x1, y1}, {x2, y2}) do
    abs(x1 - x2) + abs(y1 - y2)
  end

  def build_grid(points \\ []) do
    for row <- 0..@grid_size, col <- 0..@grid_size, into: %{} do
      if {row, col} in points do
        {{row, col}, :point}
      else
        {{row, col}, closest_point({row, col}, points)}
      end
    end
  end

  def closest_point(coord, points) do
    distances =
      points
      |> Enum.map(fn point ->
        {point, manhattan(coord, point)}
      end)
      |> Enum.sort_by(fn {_point, distance} -> distance end)

    {point1, distance1} = Enum.at(distances, 0)
    {_point2, distance2} = Enum.at(distances, 1)

    if distance1 < distance2 do
      point1
    else
      :draw
    end
  end

  def part2(file) do

    grid =
      file
      |> Utils.input_lines_into_list()
      |> Enum.map(fn line ->
        [x, y] = String.split(line, ", ")
        {String.to_integer(x), String.to_integer(y)}
      end)

      {mins, maxes} = bounds_of_grid(grid)

      IO.inspect {mins, maxes}

      all_coordinates(mins, maxes)
      |> Enum.count(fn coord -> safety_score(coord, grid) < 10_000 end)
  end


  def bounds_of_grid(points) do
    {{min_x, _}, {max_x, _}} = Enum.min_max_by(points, fn {x, _} -> x end)
    {{_, min_y}, {_, max_y}} = Enum.min_max_by(points, fn {_, y} -> y end)

    {{min_x, min_y}, {max_x, max_y}}
  end

  def all_coordinates({min_x, min_y}, {max_x, max_y}) do
    for x <- min_x..max_x, y <- min_y..max_y, do: {x, y}
  end

  def safety_score(coord, points) do
    points
    |> Enum.map(fn point -> manhattan(point, coord) end)
    |> Enum.sum()
  end

end
