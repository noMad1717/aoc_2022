defmodule Day05 do

  defp split_input(lines, acc \\ [])

  defp split_input([head | tail], acc) when head !== "" do
    acc = acc ++ [head]
    split_input(tail, acc)
  end

  defp split_input([head | tail], acc) when head === "" do
    %{crates: acc, rules: tail}
  end

  defp build_stacks(lines) do
    num_stacks = div(byte_size(hd(lines)) + 1, 4)
    pairs = for x <- 1..num_stacks, do: {x, []}
    acc = Map.new(pairs)
    build_stacks(lines, acc)
  end

  defp build_stacks([head | tail], acc) when length(tail) > 0 do
    elems = String.split(head, "", trim: true) |> Enum.chunk_every(4) |> Enum.map(fn x -> List.pop_at(x, 1) |> Tuple.to_list |> hd end)
    acc = insert(acc, 1, elems)
    build_stacks(tail, acc)
  end

  defp build_stacks(list, acc) when length(list) === 1 do
    acc
  end

  defp insert(stacks, i, elems) when length(elems) > 0 do
    [head | tail] = elems
    if (String.length(String.trim(head)) > 0) do
      stacks = Map.update!(stacks, i, fn x -> x ++ [head] end)
      insert(stacks, i + 1, tail)
    else
      insert(stacks, i + 1, tail)
    end
  end

  defp insert(stacks, _, []) do
    stacks
  end

  defp apply_rules([head | tail], stacks, fun) do
    [move | [from | [to | _]]] = String.split(head, " ", trim: true) |> tl |> Enum.take_every(2) |> Enum.map(fn x -> String.to_integer(x) end)
    moved = fun.(stacks[from], move - 1)
    stacks = Map.update!(stacks, from, fn x -> Enum.slice(x, move..10000) end)
    stacks = Map.update!(stacks, to, fn x -> moved ++ x end)
    apply_rules(tail, stacks, fun)
  end

  defp apply_rules([], stacks, _) do
    stacks
  end

  defp move_crates(input, fun) do
    map = String.split(input, "\n") |> split_input
    crates = build_stacks(map[:crates])
    apply_rules(map[:rules], crates, fun) |> Map.values |> Enum.map(fn x -> hd(x) end) |> Enum.reduce(fn x, y -> y<>x end)
  end

  def part_one(input) do
    move_crates(input, fn x, y -> Enum.slice(x, 0..y) |> Enum.reverse end)
  end

  def part_two(input) do
    move_crates(input, fn x, y -> Enum.slice(x, 0..y) end)
  end

  def run do
    {:ok, input} = File.read("lib/day05/input")
    IO.puts(part_one(input))
    IO.puts(part_two(input))
  end
end
