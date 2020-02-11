defmodule Weathers.Airport do
  require Logger

  @user_agent [{ "User-agent", "Elixir Test Browser" }]
  @url Application.get_env(:weathers, :weathers_gov_url)

  def fetch(loc) do
    Logger.info("Fetch #{loc}'s xml")
    weather_url(loc)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  def weather_url(loc) do
    "#{@url}/#{String.upcase(loc)}.xml"
  end

  def handle_response({ :ok, %{ status_code: 200, body: body } }) do
    Logger.info("Success")
    { :ok, body }
  end

  def handle_response({ _, %{ status_code: code, body: body } }) do
    Logger.error("Error. code=#{code}")
    { :error, body }
  end
end
