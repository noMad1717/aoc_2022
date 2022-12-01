defmodule Util do
  defp to_list(lines, delim, acc) when length(lines) > 0 do
    [head | tail] = lines
    acc = acc ++ String.split(head, delim, trim: true)
    to_list(tail, delim, acc)
  end

  defp to_list([], _, acc) do
    acc
  end

  def file_to_list(file, delim) do
    lines = String.split(file, "\n", trim: true)
    to_list(lines, delim, [])
  end

  defp to_jagged_arr(lines, delim, acc) when length(lines) > 0 do
    [head | tail] = lines
    if head === delim do
      acc = [[]] ++ acc
      to_jagged_arr(tail, delim, acc)
    else
      [curr | rest] = acc
      curr = curr ++ [head]
      acc = [curr] ++ rest
      to_jagged_arr(tail, delim, acc)
    end
  end

  defp to_jagged_arr([], _, acc) do
    acc
  end

  def file_to_jagged_arr(file, delim, trim, fun) do
    lines = String.split(file, "\n", trim: trim)
    to_jagged_arr(lines, delim, [[]]) |> Enum.map(&(Enum.map(&1, fun)))
  end

  def file_to_jagged_arr(file, delim, trim) do
    lines = String.split(file, "\n", trim: trim)
    to_jagged_arr(lines, delim, [[]])
  end
end
