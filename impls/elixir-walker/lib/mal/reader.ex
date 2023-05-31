defmodule MAL.Reader do
  @moduledoc """
  The reader module
  holds functions related to the reader
  """
  alias MAL.Core

  @doc """
  returns the token at the current position and increments the position
  """
  def next() do
  end

  @doc """
  returns the token at the current position
  """
  def peek() do
  end

  @doc """
  returns a new instance of tokens
  """
  def read_str(str) do
    form =
      str
      |> tokenize()
      |> read_form

    case form do
      {:ok, _, []} -> form
      {:ok, _, _} -> {:error, "parse error"}
      {:error, _} -> form
    end
  end

  # peek at the first token in the Reader and switch on the first character of that token
  defp read_form([]) do
    {:error, "unexpected ending"}
  end

  defp read_form([token | rest] = tokens) do
    case token do
      "(" ->
        read_list(rest, [])

      _ ->
        read_atom(tokens)
    end
  end

  # repeatedly call read_form with the Reader object until it encounters a ')' token
  defp read_list([], _acc) do
    {:error, "EOF: no matching \')\'"}
  end

  defp read_list([token | rest] = tokens, acc) do
    case token do
      ")" ->
        {:ok, {:list, Enum.reverse(acc)}, rest}

      _ ->
        case form = read_form(tokens) do
          {:ok, token, rest} -> read_list(rest, [token | acc])
          {:error, _} -> form
        end
    end
  end

  # look at the contents of the token and return the appropriate scalar (simple/single) data type value
  defp read_atom([token | rest]) do
    token =
      cond do
        token === "nil" ->
          {nil}

        token === "true" ->
          {:bool, true}

        token === "false" ->
          {:bool, false}

        Regex.match?(~r/^"(?:\\.|[^\\"])*"$/, token) ->
          Core.string(token)

        Regex.match?(~r/^"(?:\\.|[^\\"])*$/, token) ->
          {:error, "EOF: no matching \""}

        Regex.match?(~r/^[-+]?([1-9]\d*|0)$/, token) ->
          Core.int(token)

        Regex.match?(~r/^[-+]?([1-9]\d*|0)(\.\d*|e[-+]?\d+)$/, token) ->
          Core.float(token)

        true ->
          Core.symbol(token)
      end

    with {:error, _} <- token do
      token
    else
      _ -> {:ok, token, rest}
    end
  end

  # take a single string and return an array/list of all the tokens (strings) in it
  #
  # [\s,]*(~@|[\[\]{}()'`~^@]|"(?:\\.|[^\\"])*"?|;.*|[^\s\[\]{}('"`,;)]*)
  defp tokenize(str) do
    str = String.trim(str)
    regex = ~r/[\s,]*(~@|[\[\]{}()'`~^@]|"(?:\\.|[^\\"])*"?|;.*|[^\s\[\]{}('"`,;)]*)/

    Regex.scan(regex, str, capture: :all_but_first)
    |> List.flatten()
    |> remove_empty()
  end

  defp remove_empty(list) do
    list
    |> Enum.filter(&(&1 != ""))
  end
end
