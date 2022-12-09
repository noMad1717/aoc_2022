defmodule Day09 do

  defp ex([move | tail], rope) do
    [dir, i] = String.split(move, " ", trim: true)
    rope = mv(rope, dir, String.to_integer(i))
    ex(tail, rope)
  end

  defp ex([], rope) do
    rope[:tail][:steps] |> MapSet.size
  end

  defp mv(rope, dir, i) when i > 0 do
    segs = Map.keys(rope)
    case dir do
      "U" ->
        rope = do_move(segs, :y, :x, :sub, rope)
        mv(rope, dir, i - 1)
      "D" ->
        rope = do_move(segs, :y, :x, :add, rope)
        mv(rope, dir, i - 1)
      "L" ->
        rope = do_move(segs, :x, :y, :sub, rope)
        mv(rope, dir, i - 1)
      "R" ->
        rope = do_move(segs, :x, :y, :add, rope)
        mv(rope, dir, i - 1)
    end
  end

  defp mv(rope, _, 0) do
    rope
  end

  defp do_move([seg | rest], axis, other_axis, mode, rope) do
    if seg === :head do
      m = rope[seg]
      m = Map.put(m, :point, new_point(m[:point], mode, axis))
      rope = Map.put(rope, seg, m)
      do_move(rest, axis, other_axis, mode, rope)
    else
      cur = rope[seg]
      prev = rope[cur[:prev]]
      [px, py] = Tuple.to_list(prev[:point])
      [cx, cy] = Tuple.to_list(cur[:point])
      dx = abs(cx - px)
      dy = abs(cy - py)
      cond do
        (dx >= 2 && dy >= 1) || (dx >= 1 && dy >= 2) ->
          nx = if px > cx, do: cx + 1, else: cx - 1
          ny = if py > cy, do: cy + 1, else: cy - 1
          cur = Map.put(cur, :point, {nx, ny})
          cur = Map.put(cur, :steps, MapSet.put(cur[:steps], cur[:point]))
          rope = Map.put(rope, seg, cur)
          do_move(rest, axis, other_axis, mode, rope)
        dx >= 2 ->
          nx = if px > cx, do: cx + 1, else: cx - 1
          cur = Map.put(cur, :point, {nx, cy})
          cur = Map.put(cur, :steps, MapSet.put(cur[:steps], cur[:point]))
          rope = Map.put(rope, seg, cur)
          do_move(rest, axis, other_axis, mode, rope)
        dy >= 2 ->
          ny = if py > cy, do: cy + 1, else: cy - 1
          cur = Map.put(cur, :point, {cx, ny})
          cur = Map.put(cur, :steps, MapSet.put(cur[:steps], cur[:point]))
          rope = Map.put(rope, seg, cur)
          do_move(rest, axis, other_axis, mode, rope)
        true -> rope
      end
    end
  end

  defp do_move([], _, _, _, rope) do
    rope
  end

  defp new_point(cur, :add, axis) do
    [cx, cy] = Tuple.to_list(cur)
    case axis do
      :x -> {cx + 1, cy}
      :y -> {cx, cy + 1}
    end
  end

  defp new_point(cur, :sub, axis) do
    [cx, cy] = Tuple.to_list(cur)
    case axis do
      :x -> {cx - 1, cy}
      :y -> {cx, cy - 1}
    end
  end

  def part_one(input) do
    rope = %{head: %{point: {1000, 1000}}, tail: %{prev: :head, point: {1000, 1000}, steps: MapSet.new([{1000, 1000}])}}
    String.split(input, "\n", trim: true) |> ex(rope)
  end

  def part_two(input) do
    rope = %{head: %{point: {1000, 1000}},
      head1: %{prev: :head, point: {1000, 1000}, steps: MapSet.new()},
      head2: %{prev: :head1, point: {1000, 1000}, steps: MapSet.new()},
      head3: %{prev: :head2, point: {1000, 1000}, steps: MapSet.new()},
      head4: %{prev: :head3, point: {1000, 1000}, steps: MapSet.new()},
      head5: %{prev: :head4, point: {1000, 1000}, steps: MapSet.new()},
      head6: %{prev: :head5, point: {1000, 1000}, steps: MapSet.new()},
      head7: %{prev: :head6, point: {1000, 1000}, steps: MapSet.new()},
      head8: %{prev: :head7, point: {1000, 1000}, steps: MapSet.new()},
      tail: %{prev: :head8, point: {1000, 1000}, steps: MapSet.new([{1000, 1000}])}
    }
    String.split(input, "\n", trim: true) |> ex(rope)
  end

  def part_two(input, rope) do
    String.split(input, "\n", trim: true) |> ex(rope)
  end

  def run do
    {:ok, input} = File.read("lib/day09/input")
    IO.puts(part_one(input))
    IO.puts(part_two(input))
  end
end
