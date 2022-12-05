defmodule Day05Test do
  use ExUnit.Case
  doctest Day05

  test "gets correct result for part 1" do
    input = "    [D]    \n[N] [C]    \n[Z] [M] [P]\n 1    2    3\n\nmove 1 from 2 to 1\nmove 3 from 1 to 3\nmove 2 from 2 to 1\nmove 1 from 1 to 2"
    expected = "CMZ"

    assert Day05.part_one(input) === expected
  end

  test "gets correct result for part 2" do
    input = "    [D]    \n[N] [C]    \n[Z] [M] [P]\n 1    2    3\n\nmove 1 from 2 to 1\nmove 3 from 1 to 3\nmove 2 from 2 to 1\nmove 1 from 1 to 2"
    expected = "MCD"

    assert Day05.part_two(input) === expected
  end
end
