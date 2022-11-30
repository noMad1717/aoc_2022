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
end
