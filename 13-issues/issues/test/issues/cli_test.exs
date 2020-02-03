defmodule CliTest do
  use ExUnit.Case
  doctest Issues

  import Issues.CLI, only: [parse_args: 1,
                            sort_list: 1,
                            convert_list: 1]

  test ":help returned by option parsing with -h options" do
    assert parse_args(["-h", "anything"]) == :help
  end

  test ":help returned by option parsing with -help options" do
    assert parse_args(["--help", "anything"]) == :help
  end

  test "three values returned if three given" do
    assert parse_args(["user", "project", "99"]) == { "user", "project", 99 }
  end

  test "count is defaulted if two values given" do
    assert parse_args(["user", "project"]) == { "user", "project", 4 }
  end

  test "sort list" do
    result = sort_list(fake_created_at_list(["c", "a", "b"]))
    issues = for issue <- result, do: issue["created_at"]
    assert issues == ~w{a b c}
  end

  defp fake_created_at_list(list) do
    data = for value <- list, do: [{ "created_at", value }, { "other_data", "xxx" }]
    convert_list(data)
  end
end
