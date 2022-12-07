defmodule Day07 do

  defp ls([row | tail], size) do
    unless String.starts_with?(row, "$") do
      [head | _] = String.split(row, " ", trim: true)
      case head do
        "dir" -> ls(tail, size)
        _ ->
          size = size + String.to_integer(head)
          ls(tail, size)
      end
    else
      size
    end
  end

  defp ls([], size) do
    size
  end

  defp exec([_ | tail], cur, dirs) when cur == nil do
    cur = %{path: "/", parent: nil, size: 0}
    dirs = Map.put(dirs, "/", cur)
    exec(tail, cur, dirs)
  end

  defp exec([row | tail], cur, dirs) do
    parts = String.split(row, " ", trim: true)
    len = length(parts)
    case len do
      3 ->
        [target | _] = Enum.slice(parts, -1..-1)
        case target do
          ".." ->
            next = dirs[cur[:parent]]
            next = Map.update!(next, :size, fn x -> x + cur[:size] end)
            dirs = Map.put(dirs, next[:path], next)
            exec(tail, next, dirs)
          _ ->
            path = cur[:path]<>target<>"/"
            next = %{path: path, parent: cur[:path], size: 0}
            dirs = Map.put(dirs, path, next)
            exec(tail, next, dirs)
        end
      _ ->
        if row == "$ ls" do
          size = ls(tail, 0)
          cur = Map.update!(cur, :size, fn x -> x + size end)
          dirs = Map.put(dirs, cur[:path], cur)
          exec(tail, cur, dirs)
        else
          exec(tail, cur, dirs)
        end
    end
  end

  defp exec([], cur, dirs) do
    parent = dirs[cur[:parent]]
    if parent == nil do
      dirs
    else
      parent = Map.update!(parent, :size, fn x -> x + cur[:size] end)
      dirs = Map.put(dirs, parent[:path], parent)
      exec([], parent, dirs)
    end
  end

  def part_one(input) do
    String.split(input, "\n", trim: true) |> exec(nil, %{}) |> Map.values |> Enum.map(fn x -> x[:size] end) |> Enum.filter(fn x -> x <= 100000 end) |> Enum.sum
  end

  def part_two(input) do
    dirs = String.split(input, "\n", trim: true) |> exec(nil, %{})
    space = 70000000 - dirs["/"][:size]
    diff = 30000000 - space
    Map.values(dirs) |> Enum.map(fn x -> x[:size] end) |> Enum.filter(fn x -> x >= diff end) |> Enum.sort(:asc) |> hd
  end

  def run do
    {:ok, input} = File.read("lib/day07/input")
    IO.puts(part_one(input))
    IO.puts(part_two(input))
  end
end
