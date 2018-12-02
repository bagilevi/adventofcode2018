defmodule Day2 do
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
