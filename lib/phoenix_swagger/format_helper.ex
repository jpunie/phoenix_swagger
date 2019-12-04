defmodule FormatHelper do

  @exceptions [NaiveDateTime, DateTime]

  @moduledoc """
  Provides format-related functions.
  """
  def kebabelize(list) when is_list(list) do
    list
    |> Enum.map(&kebabelize/1)
  end
  def kebabelize(%{__struct__: struct} = value)
      when struct in @exceptions, do: value
  def kebabelize(map) when is_map(map) do
    map
    |> Enum.map(fn {key, value} -> {kebabelize_key(key), kebabelize(value)} end)
    |> Enum.into(%{})
  end
  def kebabelize(value), do: value

  defp kebabelize_key(key) when is_atom(key), do: key |> to_string |> kebabelize_key

  defp kebabelize_key(key) when is_bitstring(key) do
    key
    |> Recase.to_kebab()
  end

  def snakelize(map) when is_map(map) do
    map
    |> Enum.map(fn {key, value} -> {snakelize_key(key), snakelize(value)} end)
    |> Enum.into(%{})
  end
  def snakelize(list) when is_list(list) do
    list
    |> Enum.map(&snakelize/1)
  end
  def snakelize(value), do: value

  defp snakelize_key(key) when is_atom(key), do: key |> to_string |> snakelize_key

  defp snakelize_key(key) when is_bitstring(key) do
    key
    |> Recase.to_snake()
  end

  def camelize(map) when is_map(map) do
    map
    |> Enum.map(fn {key, value} -> {camelize_key(key), camelize(value)} end)
    |> Enum.into(%{})
  end
  def camelize(list) when is_list(list) do
    list
    |> Enum.map(&camelize/1)
  end
  def camelize(value), do: value

  defp camelize_key(key) when is_atom(key), do: key |> to_string |> camelize_key

  defp camelize_key(key) when is_bitstring(key) do
    key
    |> Recase.to_camel()
  end

end
