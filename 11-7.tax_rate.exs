defmodule Order do
  def parse do
    {:ok, fp} = File.open("./11-7.orders.csv")

    header = Enum.map(split(IO.read(fp, :line)), &String.to_atom/1)
    Enum.map(IO.stream(fp, :line), &(convert(&1, header)))
  end

  defp convert(str, header) do
    #Enum.zip(header, split(str))
    [id, ship_to, amount] = split(str)
    ship_to = ship_to
    |> String.trim(":")
    |> String.to_atom
    Enum.zip(header, [id, ship_to, String.to_float(amount)])
  end

  defp split(str) do
    str
    |> String.trim
    |> String.split(",")
  end
end

defmodule TaxRate do
  @tax_rates [ NC: 0.075, TX: 0.08 ]

  def calc(list) do
    for x <- list do
      total = x[:net_amount] * (1 + (@tax_rates[x[:ship_to]] || 0))
      x ++ [total_amount: total]
    end
  end
end

orders = Order.parse()

IO.inspect(TaxRate.calc(orders))
