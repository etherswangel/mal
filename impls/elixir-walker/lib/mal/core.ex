defmodule MAL.Core do
  @moduledoc """
  The Core module, contains basic functions
  """

  @doc """
  read user input
  """
  def read_line() do
    IO.gets("user> ")
  end

  @doc """
  print string
  """
  def print_line(str, readably)
      when is_boolean(readably) do
    IO.puts(str)
  end

  def print_line(str, :debug) do
    IO.inspect(str)
  end

  @doc """
  returns true if term is int, false if is not
  """
  def is_int(term) do
    case term do
      {:int, _} -> true
      _ -> false
    end
  end

  @doc """
  returns true if term is float, false if is not
  """
  def is_float(term) do
    case term do
      {:float, _} -> true
      _ -> false
    end
  end

  @doc """
  returns true if term is string, false if is not
  """
  def is_string(term) do
    case term do
      {:string, _} -> true
      _ -> false
    end
  end

  @doc """
  returns true if term is symbol, false if is not
  """
  def is_symbol(term) do
    case term do
      {:symbol, _} -> true
      _ -> false
    end
  end

  @doc """
  parse string into int, returns {:int, num}
  """
  def int(str) do
    {:int, Integer.parse(str) |> elem(0)}
  end

  @doc """
  parse string into float, returns {:float, num}
  """
  def float(str) do
    {:float, Float.parse(str) |> elem(0)}
  end

  @doc """
  parse string into string, returns {:string, num}
  """
  def string(str) do
    {:string, Code.string_to_quoted(str) |> elem(1)}
  end

  @doc """
  parse string into symbol, returns {:symbol, num}
  """
  def symbol(str) do
    {:symbol, str}
  end
end
