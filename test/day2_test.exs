defmodule Day2Test do
  use ExUnit.Case
  import Day2
  doctest Day2

  describe "part1" do
    test "example" do
      assert letter_counts("abcdef") == {0, 0} # contains no letters that appear exactly two or three times.
      assert letter_counts("bababc") == {1, 1} # contains two a and three b, so it counts for both.
      assert letter_counts("abbcde") == {1, 0} # contains two b, but no letter appears exactly three times.
      assert letter_counts("abcccd") == {0, 1} # contains three c, but no letter appears exactly two times.
      assert letter_counts("aabcdd") == {1, 0} # contains two a and two d, but it only counts once.
      assert letter_counts("abcdee") == {1, 0} # contains two e.
      assert letter_counts("ababab") == {0, 1} # contains three a and three b, but it only counts once.

      assert checksum("""
        abcdef
        bababc
        abbcde
        abcccd
        aabcdd
        abcdee
        ababab
      """) == 12
    end

    test "my input" do
      assert checksum({:file, "inputs/day2"}) == 9139
    end
  end

  describe "part2" do
    test "example" do
      assert similarity("abcde", "axcye") == nil
      assert similarity("fghij", "fguij") == "fgij"

      assert find_common_letters("""
        abcde
        fghij
        klmno
        pqrst
        fguij
        axcye
        wvxyz
      """) == "fgij"
    end

    test "my input" do
      assert find_common_letters({:file, "inputs/day2"}) == "uqcidadzwtnhsljvxyobmkfyr"
    end
  end
end
