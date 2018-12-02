defmodule Day2 do
  # Part One

  def letter_counts(id) do
    counts =
      id
      |> String.split("", trim: true)
      |> Enum.reduce(%{}, fn char, counts ->
        Map.update(counts, char, 1, &(&1 + 1))
      end)
      |> Enum.reduce({0, 0}, fn {char, count}, {c2, c3} ->
        case count do
          2 -> {1, c3}
          3 -> {c2, 1}
          _ -> {c2, c3}
        end
      end)
  end

  def checksum(input) do
    {sum2, sum3} =
      parse(input)
      |> Enum.reduce({0, 0}, fn id, {sum2, sum3} ->
        {c2, c3} = letter_counts(id)
        {sum2 + c2, sum3 + c3}
      end)

    sum2 * sum3
  end

  # Part Two

  def similarity(a, b) do
    a = a |> String.split("", trim: true)
    b = b |> String.split("", trim: true)
    {_, diffs, common_rev} =
      Enum.reduce_while(a, {b, 0, []}, fn c1, {b_rest, diffs, common_rev} ->
        [c2 | b_rest] = b_rest
        if c1 == c2 do
          {:cont, {b_rest, diffs, [c1 | common_rev]}}
        else
          {(if diffs == 0, do: :cont, else: :halt), {b_rest, diffs + 1, common_rev}}
        end
      end)
    if diffs == 1 do
      common_rev |> Enum.reverse |> Enum.join("")
    end
  end

  def find_common_letters(input) do
    ids = parse(input)
    Enum.reduce_while(ids, tl(ids), fn id, id_tail ->
      sim = find_for_id(id, id_tail)
      if sim do
        {:halt, sim}
      else
        {:cont, tl(id_tail)}
      end
    end)
  end

  def find_for_id(id, other_ids) do
    Enum.reduce_while(other_ids, nil, fn other_id, _ ->
      sim = similarity(id, other_id)
      if sim do
        {:halt, sim}
      else
        {:cont, nil}
      end
    end)
  end


  # Utils

  def parse({:file, filename}) do
    {:ok, input} = File.read(filename)
    parse(input, "\n")
  end

  def parse(input, sep \\ "\n") do
    input
    |> String.split(sep, trim: true)
    |> Enum.map(&String.trim/1)
  end
end
