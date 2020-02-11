defmodule Weathers.CLI do

  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [help: :boolean],
                                     aliases: [h: :help])

    case parse do
      { [help: true], _, _ } -> :help
      { _, [loc], _ } -> { loc }
      _ -> :help
    end
  end

  def process(:help) do
    IO.puts """
    usage: weathers <loc>
    """
    System.halt(0)
  end

  def process({ loc }) do
    Weathers.Airport.fetch(loc)
    |> decode_response
    # |> convert_list
    # |> sort_list
    # |> Enum.take(count)
    # |> TF.print_table_for_columns(["number", "created_at", "title"])
  end

  def decode_response({ :ok, body }) do
    { doc, _ } = body
                 |> :binary.bin_to_list
                 |> :xmerl_scan.string
    IO.inspect doc
  end

  def decode_response({ :error, body }) do
    { _, message } = List.keyfind(body, "message", 0)
    IO.puts "Error: #{message}"
    System.halt(2)
  end

  # def convert_list(list) do
  #   list
  #   |> Enum.map(&Enum.into(&1, Map.new))
  # end

  # def sort_list(list) do
  #   Enum.sort(list, fn i1, i2 -> i1["created_at"] <= i2["created_at"] end)
  # end
end
