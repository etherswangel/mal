defmodule Mix.Tasks.Step0Repl do
  use Mix.Task

  @impl true
  def run(_args), do: loop()

  defp loop do
    read_line()
    |> rep
    |> IO.puts

    loop()
  end

  defp read_line() do
    IO.gets("user> ")
  end

  defp read(input) do
    input
  end

  defp eval(input) do
    input
  end

  defp print(input) do
    input
  end

  defp rep(:eof) do
    exit(:normal)
  end

  defp rep(line) do
    read(line)
    |> eval
    |> print
  end
end

