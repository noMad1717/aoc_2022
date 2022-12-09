defmodule Day08 do

  defp to_int_grid(input) do
    String.split(input, "\n", trim: true) |> Enum.map(fn x -> String.split(x, "", trim: true) |> Enum.map(fn x -> String.to_integer(x) end) end)
  end

  defp visible_col?(pivot, grid) do
    {x, y} = pivot
    col = Enum.map(grid, fn l -> List.pop_at(l, x) |> Tuple.to_list |> hd end)
    {val , _} = List.pop_at(col, y)
    Enum.all?(Enum.slice(col, 0..(y - 1)), fn v -> v < val end) || Enum.all?(Enum.slice(col, (y + 1)..10000), fn v -> v < val end)
  end

  defp visible_row?(pivot, grid) do
    {x, y} = pivot
    row = List.pop_at(grid, y) |> Tuple.to_list |> hd
    {val, _} = List.pop_at(row, x)
    Enum.all?(Enum.slice(row, 0..(x - 1)), fn v -> v < val end) || Enum.all?(Enum.slice(row, (x + 1)..10000), fn v -> v < val end)
  end

  defp check_vis(pivot, grid) do
    if visible_col?(pivot, grid) || visible_row?(pivot, grid) do
      1
    else
      0
    end
  end

  defp count_trees_col(pivot, grid) do
    {x, y} = pivot
    if (y === 0 || y === length(grid) - 1 || x === 0 || x === length(hd(grid)) - 1) do
      0
    else
      col = Enum.map(grid, fn l -> List.pop_at(l, x) |> Tuple.to_list |> hd end)
      {val, _} = List.pop_at(col, y)
      top = cnt(Enum.slice(col, 0..(y - 1)) |> Enum.reverse, val, 0)
      bottom = cnt(Enum.slice(col, (y + 1)..10000), val, 0)
      top * bottom
    end
  end

  defp count_trees_row(pivot, grid) do
    {x, y} = pivot
    if (y === 0 || y === length(grid) - 1 || x === 0 || x === length(hd(grid)) - 1) do
      0
    else
      row = List.pop_at(grid, y) |> Tuple.to_list |> hd
      {val, _} = List.pop_at(row, x)
      left = cnt(Enum.slice(row, 0..(x - 1)) |> Enum.reverse, val, 0)
      right = cnt(Enum.slice(row, (x + 1)..10000), val, 0)
      left * right
    end
  end

  defp cnt([head | tail], val, acc) when head < val do
    acc = acc + 1
    cnt(tail, val, acc)
  end

  defp cnt([head | _], val, acc) when head >= val do
    acc = acc + 1
    acc
  end

  defp cnt([], _, acc) do
    acc
  end

  def part_one(input) do
    grid = to_int_grid(input)
    h = length(grid)
    w = hd(grid) |> length
    s = Enum.map(1..(h - 2), fn y -> Enum.map(1..(w - 2), fn x -> check_vis({x, y}, grid) end) |> Enum.sum end) |> Enum.sum
    s + (w * 2) + (h * 2) - 4
  end

  def part_two(input) do
    grid = to_int_grid(input)
    h = length(grid)
    w = hd(grid) |> length
    Enum.map(0..(h - 1), fn y -> Enum.map(0..(w - 1), fn x -> count_trees_col({x, y}, grid) * count_trees_row({x, y}, grid) end) end) |> Enum.map(fn x -> Enum.sort(x, :desc) |> hd end) |> Enum.sort(:desc) |> hd
  end

  def run do
    {:ok, input} = File.read("lib/day08/input")
    IO.puts(part_one(input))
    IO.puts(part_two(input))
  end
end
