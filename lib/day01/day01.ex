defmodule Day01 do
  import Util, only: [file_to_jagged_arr: 4]

  def part_one(input) do
    elves = file_to_jagged_arr(input, "", false, fn x -> String.to_integer(x) end)
    Enum.map(elves, fn x -> Enum.sum(x) end) |> Enum.sort(:desc) |> hd
  end

  def part_two(input) do
    elves = file_to_jagged_arr(input, "", false, fn x -> String.to_integer(x) end)
    Enum.map(elves, fn x -> Enum.sum(x) end) |> Enum.sort(:desc) |> Enum.take(3) |> Enum.sum
  end

  def run do
    {:ok, input} = File.read("lib/day01/input")
    IO.puts(part_one(input))
    IO.puts(part_two(input))
  end
end
