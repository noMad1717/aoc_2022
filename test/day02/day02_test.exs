defmodule Day02Test do
  use ExUnit.Case
  doctest Day02

  test "gets correct result for part 1" do
    input = "A Y\nB X\nC Z"
    expected = 15

    assert Day02.part_one(input) === expected
  end

  test "gets correct result for part 2" do
    input = "A Y\nB X\nC Z"
    expected = 12

    assert Day02.part_two(input) === expected
  end
end
