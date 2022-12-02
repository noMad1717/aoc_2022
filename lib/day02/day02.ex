defmodule Day02 do

  def part_one(input) do
    vals = %{"A" => %{"X" => 4, "Y" => 8, "Z" => 3}, "B" => %{"X" => 1, "Y" => 5, "Z" => 9}, "C" => %{"X" => 7, "Y" => 2, "Z" => 6}}
    String.split(input, "\n", trim: true) |> Enum.map(fn x -> vals[String.at(x, 0)][String.at(x, 2)] end) |> Enum.sum
  end

  def part_two(input) do
    vals = %{"A" => %{"X" => 3, "Y" => 4, "Z" => 8}, "B" => %{"X" => 1, "Y" => 5, "Z" => 9}, "C" => %{"X" => 2, "Y" => 6, "Z" => 7}}
    String.split(input, "\n", trim: true) |> Enum.map(fn x -> vals[String.at(x, 0)][String.at(x, 2)] end) |> Enum.sum
  end

  def run do
    {:ok, input} = File.read("lib/day02/input")
    IO.puts(part_one(input))
    IO.puts(part_two(input))
  end
end
