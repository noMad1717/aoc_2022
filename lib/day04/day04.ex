defmodule Day04 do

  defp to_set(pair) do
    [start | [finish | _]] = String.split(pair, "-") |> Enum.map(&(String.to_integer(&1)))
    MapSet.new(start..finish)
  end

  defp find_overlap(pairs, fun) do
    fun.(hd(pairs), tl(pairs) |> hd)
  end

  defp calc_overlaps(input, fun) do
    String.split(input, "\n", trim: true) |> Enum.map(fn x -> String.split(x, ",", trim: true) |> Enum.map(&(to_set(&1))) |> find_overlap(fun) end) |> Enum.sum
  end

  def part_one(input) do
    calc_overlaps(input, &(if (MapSet.subset?(&1, &2) || MapSet.subset?(&2, &1)), do: 1, else: 0))
  end

  def part_two(input) do
    calc_overlaps(input, &(if length(MapSet.intersection(&1, &2) |> Enum.to_list) > 0, do: 1, else: 0))
  end

  def run do
    {:ok, input} = File.read("lib/day04/input")
    IO.puts(part_one(input))
    IO.puts(part_two(input))
  end
end
