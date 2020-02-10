defmodule Issues.CLI do
  import Issues.TableFormatter
  @default_count 4

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
      { _, [ user, project, count], _ } -> { user, project, String.to_integer(count) }
      { _, [user, project], _ } -> { user, project, @default_count }
      _ -> :help
    end
  end

  def process(:help) do
    IO.puts """
    usage: issues <user> <project> [count]
    """
    System.halt(0)
  end

  def process({ user, project, count }) do
    Issues.GithubIssues.fetch(user, project)
    |> decode_response
    |> convert_list
    |> sort_list
    |> Enum.take(count)
    |> print_table_for_columns(["number", "created_at", "title"])
  end

  def decode_response({ :ok, body }) do
    body
  end

  def decode_response({ :error, body }) do
    { _, message } = List.keyfind(body, "message", 0)
    IO.puts "Error: #{message}"
    System.halt(2)
  end

  def convert_list(list) do
    list
    |> Enum.map(&Enum.into(&1, Map.new))
  end

  def sort_list(list) do
    Enum.sort(list, fn i1, i2 -> i1["created_at"] <= i2["created_at"] end)
  end
end
