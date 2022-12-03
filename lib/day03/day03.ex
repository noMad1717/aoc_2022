defmodule Day03 do

  defp split_eq(string) do
    String.split_at(string, div(byte_size(string), 2)) |> Tuple.to_list
  end

  defp to_set(string) do
    String.split(string, "", trim: true) |> MapSet.new
  end

  defp get_dup([first | tail]) when length(tail) > 1 do
    [second | tail] = tail
    dups = MapSet.intersection(first, second)
    tail = [dups] ++ tail
    get_dup(tail)
  end

  defp get_dup([first | tail]) when length(tail) === 1 do
    MapSet.intersection(first, hd(tail)) |> MapSet.to_list |> hd
  end

  defp get_val(char) do
    <<bin::utf8>> = char
    cond do
      bin < ?a -> (bin - ?A) + 27
      bin >= ?a -> (bin - ?a) + 1
    end
  end

  def part_one(input) do
    String.split(input, "\n", trim: true) |> Enum.map(fn x -> split_eq(x) |> Enum.map(fn x -> to_set(x) end) |> get_dup |> get_val end) |> Enum.sum
  end

  def part_two(input) do
    String.split(input, "\n", trim: true) |> Enum.chunk_every(3) |> Enum.map(fn x -> Enum.map(x, fn y -> to_set(y) end) |> get_dup |> get_val end) |> Enum.sum
  end

  def run do
    {:ok, input} = File.read("lib/day03/input")
    IO.puts(part_one(input))
    IO.puts(part_two(input))
  end
end
