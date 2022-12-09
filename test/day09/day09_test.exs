defmodule Day09Test do
  use ExUnit.Case
  doctest Day09

  test "gets correct result for part 1" do
    input = "R 4\nU 4\nL 3\nD 1\nR 4\nD 1\nL 5\nR 2"
    expected = 13

    assert Day09.part_one(input) === expected
  end

  test "gets correct result for part 2" do
    input = "R 5\nU 8\nL 8\nD 3\nR 17\nD 10\nL 25\nU 20"
    expected = 36

    assert Day09.part_two(input) === expected
  end
end
