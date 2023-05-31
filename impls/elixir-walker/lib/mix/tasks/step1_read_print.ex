defmodule Mix.Tasks.Step1ReadPrint do
  use Mix.Task
  alias MAL.{Core, Printer, Reader}

  @impl true

  # false, true, :debug
  @readably :true

  def run(_args), do: loop()

  defp loop do
    Core.read_line()
    |> rep()
    |> Core.print_line(@readably)

    loop()
  end

  defp rep(:eof) do
    exit(:normal)
  end

  defp rep(line) do
    line
    |> read()
    |> eval()
    |> print()
  end

  defp read(str) do
    Reader.read_str(str)
  end

  defp eval(ast) do
    ast
  end

  defp print(ast) do
    Printer.print_str(ast, @readably)
  end
end
