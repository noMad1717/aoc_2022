defmodule Day06Test do
  use ExUnit.Case
  doctest Day06

  test "gets correct result for part 1" do
    input = "mjqjpqmgbljsphdztnvjfqwrcgsmlb"
    expected = 7

    assert Day06.part_one(input) === expected
  end

  test "gets correct result for part 2" do
    input = "mjqjpqmgbljsphdztnvjfqwrcgsmlb"
    expected = 19

    assert Day06.part_two(input) === expected
  end
end
