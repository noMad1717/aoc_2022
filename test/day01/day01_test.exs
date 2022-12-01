defmodule Day01Test do
  use ExUnit.Case
  doctest Day01

  test "gets correct result for part 1" do
    input = "1000\n2000\n3000\n\n4000\n\n5000\n6000\n\n7000\n8000\n9000\n\n10000"
    expected = 24000

    assert Day01.part_one(input) === expected
  end

  test "gets correct result for part 2" do
    input = "1000\n2000\n3000\n\n4000\n\n5000\n6000\n\n7000\n8000\n9000\n\n10000"
    expected = 45000

    assert Day01.part_two(input) === expected
  end
end
