defmodule Aoc.Utils do
  def test do
    IO.puts("hello")
  end

  def print_list(list) when is_list(list) do
    inspect(list, char_lists: :as_lists)
  end

  def input_lines_into_list(file) do
    File.read!("./input/" <> file)
    |> String.split("\n", trim: true)
  end

end
