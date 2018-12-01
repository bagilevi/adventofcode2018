defmodule Day1 do
  # Part One

  def compute_frequency(numbers) when is_list(numbers) do
    Enum.reduce(numbers, 0, fn change, sum -> sum + change end)
  end

  def compute_frequency(input) do
    parse(input) |> compute_frequency
  end

  # Part Two

  def find_repeat_frequency(numbers) when is_list(numbers) do
    starting_frequency = 0
    iterate(numbers, [], starting_frequency, MapSet.new([starting_frequency]))
  end

  def find_repeat_frequency(input) do
    parse(input) |> find_repeat_frequency
  end

  def iterate(original_list, current_list, current_frequency, seen_frequencies) do
    # Loop through the list: take items from current_list, and when empty => set to original_list
    {current_change, current_list} = next_change(current_list, original_list)

    current_frequency = current_frequency + current_change

    if MapSet.member?(seen_frequencies, current_frequency) do
      current_frequency
    else
      seen_frequencies = MapSet.put(seen_frequencies, current_frequency)
      iterate(original_list, current_list, current_frequency, seen_frequencies)
    end
  end

  # current_list empty => use original_list
  defp next_change([], [head | rest]) do
    {head, rest}
  end

  # current_list not empty
  defp next_change([head | rest], _) do
    {head, rest}
  end

  defp number_from_line(s) do
    {i, ""} = Integer.parse(s)
    i
  end

  def parse({:file, filename}) do
    {:ok, input} = File.read(filename)
    parse(input, "\n")
  end

  def parse(input, sep \\ ", ") do
    input
    |> String.split(sep, trim: true)
    |> Enum.map(fn line -> number_from_line(line) end)
  end
end
