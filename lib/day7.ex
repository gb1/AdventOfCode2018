defmodule Aoc.Day7 do
  alias Aoc.Utils

  def part1(file) do
    input =
      file
      |> Utils.input_lines_into_list()

    graph =
      input
      |> build_graph

    starting_nodes = get_start_node(graph)

    prereq =
      input
      |> build_prereq

    bfs(graph, [], starting_nodes, prereq)
    |> List.to_string
  end

  def build_graph(input) do
    input
    |> Enum.map(fn line ->
      [part1, part2] = String.split(line, " must be finished before step ")
      [List.last(String.graphemes(part1)), List.first(String.graphemes(part2))]
    end)
    |> Enum.reduce(%{}, fn [node, child], acc ->
      Map.update(acc, node, [child], fn children -> children ++ [child] end)
    end)
  end

  def build_prereq(input) do
    input
    |> Enum.map(fn line ->
      [part1, part2] = String.split(line, " must be finished before step ")
      [List.last(String.graphemes(part1)), List.first(String.graphemes(part2))]
    end)
    |> Enum.reduce(%{}, fn [node, child], acc ->
      Map.update(acc, child, [node], fn nodes -> nodes ++ [node] end)
    end)
  end

  def get_start_node(graph) do
    {nodes, children_list} =
      graph
      |> Enum.reduce({[], []}, fn {node, children}, acc ->
        all_nodes = elem(acc, 0)
        all_children = elem(acc, 1)
        {all_nodes ++ [node], all_children ++ children}
      end)

    nodes -- children_list
  end

  def bfs(_graph, visited, [], prereq), do: visited

  def bfs(graph, visited, frontier, prereq) do

    available = frontier
    |> Enum.filter( fn(x) ->
      p =
      case prereq[x] do
        nil -> []
        p -> p
      end

      Enum.all?(p, &(Enum.member?(visited, &1)))
    end)

    IO.inspect available
    IO.inspect frontier

    IO.inspect available
    node = List.first(available)


    case graph[node] do
      nil ->
        bfs(graph, visited ++ [node], Enum.uniq(Enum.sort(frontier -- [node])), prereq)

      next_nodes ->
        bfs(
          graph,
          visited ++ [node],
          Enum.uniq(Enum.sort((frontier ++ next_nodes) -- [node])),
          prereq
        )
    end
  end
end
