defmodule Day1Test do
  use ExUnit.Case
  import Day1
  doctest Day1

  test "one item" do
    assert compute_frequency("+1") == 1
  end

  test "simple example" do
    assert compute_frequency("+1, -2, +8") == 7
  end

  test "greets the world" do
    assert compute_frequency({:file, "inputs/day1"}) == 486
  end

  describe "part two" do
    test "example" do
      assert find_repeat_frequency("+1, -1") == 0
      assert find_repeat_frequency("+3, +3, +4, -2, -4") == 10
      assert find_repeat_frequency("-6, +3, +8, +5, -6") == 5
      assert find_repeat_frequency("+7, +7, -2, -7, -4") == 14
    end

    test "custom input" do
      assert find_repeat_frequency({:file, "inputs/day1b"}) == 69285
    end
  end
end
