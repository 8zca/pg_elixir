defmodule Issues.GithubIssues do
  # requireはマクロが呼び出せるようにモジュールを要求する
  # Logger.info等で呼び出す
  require Logger

  @user_agent [{ "User-agent", "Elixir Test Browser" }]
  @github_url Application.get_env(:issues, :github_url)

  def fetch(user, project) do
    Logger.info("Fetch user #{user}'s project #{project}")
    issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  def issues_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end

  def handle_response({ :ok, %{ status_code: 200, body: body } }) do
    Logger.info("Success")
    { :ok, Poison.Parser.parse!(body) }
  end

  def handle_response({ _, %{ status_code: code, body: body } }) do
    Logger.error("Error. code=#{code}")
    { :error, Poison.Parser.parse!(body) }
  end
end
