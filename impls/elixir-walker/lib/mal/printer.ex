defmodule MAL.Printer do
  @moduledoc """
  The printer
  """

  @doc """
  take a mal data structure and return a string representation of it
  """

  def print_str({:error, msg}, readably)
      when is_boolean(readably) do
    "error: #{msg}"
  end

  def print_str({:ok, tokens, _}, readably)
      when is_boolean(readably) do
    parse(tokens, readably)
  end

  def print_str(term, :debug) do
    term
  end

  defp parse({:list, list}, readably) do
    "(#{list |> Enum.map(&parse(&1, readably)) |> Enum.join(" ")})"
  end

  defp parse({:int, int}, _) do
    Integer.to_string(int)
  end

  defp parse({:float, float}, _) do
    Float.to_string(float)
  end

  defp parse({:string, string}, true = _readably) do
    string
    |> inspect()
    # |> String.slice(1..-2)
  end

  defp parse({:string, string}, _) do
    inspect(string)
  end

  defp parse({:symbol, symbol}, _) do
    symbol
  end

  defp parse({nil}, _) do
    "nil"
  end

  defp parse({:bool, bool}, _) do
    to_string(bool)
  end
end
