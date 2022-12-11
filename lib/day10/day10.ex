defmodule Day10 do

  defp cycle([head | tail], c, x, addx, acc) do
    if (length(Map.keys(addx)) > 0 && !Map.has_key?(addx, c)) do
      acc = if Map.has_key?(acc, c), do: Map.put(acc, c, c * x), else: acc
      cycle([head] ++ tail, c + 1, x, addx, acc)
    else
      parts = String.split(head, " ", trim: true)
      addx = if length(parts) === 2, do: Map.put(addx, c + 2, String.to_integer(hd(tl(parts)))), else: addx
      acc = if Map.has_key?(acc, c), do: Map.put(acc, c, c * x), else: acc
      new_x = if Map.has_key?(addx, c), do: x + addx[c], else: x
      addx = if Map.has_key?(addx, c), do: Map.delete(addx, c), else: addx
      cycle(tail, c + 1, new_x, addx, acc)
    end
  end

  defp cycle([], _, _, _, acc) do
    acc
  end

  defp draw([head | tail], c, x, addx, acc) do
    if (length(Map.keys(addx)) > 0 && !Map.has_key?(addx, c)) do
      sprite = MapSet.new((x - 1)..(x + 1))
      pixel = if MapSet.member?(sprite, c), do: "#", else: "."
      acc = acc ++ [pixel]
      draw([head] ++ tail, Integer.mod(c + 1, 40), x, addx, acc)
    else
      parts = String.split(head, " ", trim: true)
      x = if Map.has_key?(addx, c), do: x + addx[c], else: x
      addx = if Map.has_key?(addx, c), do: Map.delete(addx, c), else: addx
      sprite = MapSet.new((x - 1)..(x + 1))
      pixel = if MapSet.member?(sprite, c), do: "#", else: "."
      acc = acc ++ [pixel]
      addx = if length(parts) === 2, do: Map.put(addx, Integer.mod(c + 2, 40), String.to_integer(hd(tl(parts)))), else: addx
      draw(tail, Integer.mod(c + 1, 40), x, addx, acc)
    end
  end

  defp draw([], _, _, _, acc) do
    acc
  end

  def part_one(input) do
    String.split(input, "\n", trim: true) |> cycle(0, 1, Map.new(), %{20 => 0, 60 => 0, 100 => 0, 140 => 0, 180 => 0, 220 => 0}) |> Map.values |> Enum.sum
  end

  def part_two(input) do
    String.split(input, "\n", trim: true) |> draw(0, 1, Map.new(), []) |> Enum.chunk_every(40) |> Enum.map(fn e -> Enum.reduce(e, fn x, y -> y <> x end) end) |> Enum.each(fn x -> IO.puts(x) end)
  end

  def run do
    {:ok, input} = File.read("lib/day10/input")
    IO.puts(part_one(input))
    part_two(input)
  end
end
