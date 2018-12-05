defmodule Aoc.Day4 do
  use Timex
  alias Aoc.Utils

  def part1(file) do
    log =
      Utils.input_lines_into_list(file)
      |> Enum.map(&String.split(&1, ["[", "]"], trim: true))
      |> Enum.map(fn [timestamp, log] ->
        action = parse_action(log)

        {parse_timestamp(timestamp), action}
      end)
      |> Enum.sort_by(&DateTime.to_unix(elem(&1, 0)))
      |> process_log("", %{})

    {sleepiest_guard, total_asleep} =
      log
      |> calculate_times
      |> Enum.max_by(fn {key, value} -> value end)

    sleepiest_minute = find_sleepiest_minute(log, sleepiest_guard)

    String.to_integer(sleepiest_guard) * sleepiest_minute
  end

  def parse_timestamp(string) do
    Timex.parse!(string, "{YYYY}-{0M}-{0D} {0h24}:{0m}")
    |> DateTime.from_naive!("Etc/UTC")
  end

  def parse_action(string) do
    cond do
      string =~ "Guard" ->
        Regex.run(~r/#(\d*)/, string)
        |> List.last()

      string =~ "falls asleep" ->
        :sleepy_time

      string =~ "wakes up" ->
        :wakey_wakey
    end
  end

  def process_log([], current_guard, logs), do: logs

  # This handles Guard x.. logs, put the guard into the map if needed and set the current guard
  def process_log([head | tail], current_guard, logs) when is_bitstring(elem(head, 1)) do
    {stamp, guard} = head
    process_log(tail, guard, Map.put_new(logs, guard, []))
  end

  def process_log([head | tail], current_guard, logs) when elem(head, 1) == :sleepy_time do
    process_log(tail, current_guard, Map.update!(logs, current_guard, &(&1 ++ [elem(head, 0)])))
  end

  def process_log([head | tail], current_guard, logs) when elem(head, 1) == :wakey_wakey do
    process_log(tail, current_guard, Map.update!(logs, current_guard, &(&1 ++ [elem(head, 0)])))
  end

  def calculate_times(logs) do
    logs
    |> Enum.map(fn {guard, times} ->
      {guard,
       times
       |> Enum.chunk_every(2)
       |> Enum.map(fn [sleep, wake] ->
         DateTime.diff(wake, sleep)
       end)
       |> Enum.sum()}
    end)
  end

  def find_sleepiest_minute(log, guard) do
    times = log[guard] |> Enum.chunk_every(2)

    times
    |> Enum.map(fn [sleep, wake] ->
      sleep_sec =
        String.to_integer(
          Time.to_string(DateTime.to_time(sleep))
          |> String.split(":")
          |> Enum.at(1)
        )

      wake_sec =
        String.to_integer(
          Time.to_string(DateTime.to_time(wake))
          |> String.split(":")
          |> Enum.at(1)
        )

      sleep_sec..(wake_sec - 1)
      |> Enum.to_list()
    end)
    |> List.flatten()
    |> Enum.sort()
    |> Enum.chunk_by(& &1)
    |> Enum.sort_by(&length(&1))
    |> Enum.reverse()
    |> List.first()
    |> List.first()
  end

  def part2(file) do
    guard_sleepy_seconds =
      Utils.input_lines_into_list(file)
      |> Enum.map(&String.split(&1, ["[", "]"], trim: true))
      |> Enum.map(fn [timestamp, log] ->
        action = parse_action(log)

        {parse_timestamp(timestamp), action}
      end)
      |> Enum.sort_by(&DateTime.to_unix(elem(&1, 0)))
      |> process_log("", %{})
      |> sleepy_seconds


      a = for i <- 0..59 do
        guard_sleepy_seconds
        |> Enum.map( fn({guard, seconds}) ->
          {i, guard, length(Enum.filter(seconds, &(&1 == i)))}
        end)

      end

      {sec, guard, _freq} = a
      |> List.flatten
      |> Enum.max_by( fn({sec, guard, freq}) -> freq end)
      sec * String.to_integer(guard)
  end

  def sleepy_seconds(logs) do
    logs
    |> Enum.map(fn {guard, times} ->
      {guard,
       times
       |> Enum.chunk_every(2)
       |> Enum.map(fn [sleep, wake] ->

        s = String.to_integer(
          Time.to_string(DateTime.to_time(sleep))
          |> String.split(":")
          |> Enum.at(1)
        )

        w = String.to_integer(
          Time.to_string(DateTime.to_time(wake))
          |> String.split(":")
          |> Enum.at(1)
        )

        s..w-1
        |> Enum.to_list
       end)
       |> List.flatten

       }
    end)
  end

end
