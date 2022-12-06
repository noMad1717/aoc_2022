defmodule Day06 do

  defp find_marker(input, len) when length(input) >= len do
    Enum.slice(input, -len..-1) |> Enum.uniq |> length === len
  end

  defp find_marker(input, len) when length(input) < len do
    false
  end

  defp scan_buf(input, i, len, buf) do
    buf = buf ++ Enum.slice(input, i..i)
    if find_marker(buf, len) do
      buf
    else
      scan_buf(input, i + 1, len, buf)
    end
  end

  def part_one(input) do
    String.split(input, "", trim: true) |> scan_buf(0, 4, []) |> length
  end

  def part_two(input) do
    String.split(input, "", trim: true) |> scan_buf(0, 14, []) |> length
  end

  def run do
    {:ok, input} = File.read("lib/day06/input")
    IO.puts(part_one(input))
    IO.puts(part_two(input))
  end
end
