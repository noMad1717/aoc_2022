defmodule Day08Test do
  use ExUnit.Case
  doctest Day08

  test "gets correct result for part 1" do
    input = "30373\n25512\n65332\n33549\n35390"
    expected = 21

    assert Day08.part_one(input) === expected
  end

  test "gets correct result for part 2" do
    input = "30373\n25512\n65332\n33549\n35390"
    expected = 8

    assert Day08.part_two(input) === expected
  end
end
