defmodule Day04Test do
  use ExUnit.Case
  doctest Day04

  test "gets correct result for part 1" do
    input = "2-4,6-8\n2-3,4-5\n5-7,7-9\n2-8,3-7\n6-6,4-6\n2-6,4-8"
    expected = 2

    assert Day04.part_one(input) === expected
  end

  test "gets correct result for part 2" do
    input = "2-4,6-8\n2-3,4-5\n5-7,7-9\n2-8,3-7\n6-6,4-6\n2-6,4-8"
    expected = 4

    assert Day04.part_two(input) === expected
  end
end
