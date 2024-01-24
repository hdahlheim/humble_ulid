defmodule HumbleUlid do
  @moduledoc """
  Documentation for `HumbleUlid`.
  """

  # Crockford base32 alphabet
  @cf_alphabet "0123456789ABCDEFGHJKMNPQRSTVWXYZ"
  # two bit padding to reach 130 bits
  @padding <<0::2>>

  @doc """
  Generates a new ULID based on the current System Time or the provided timestamp

  Defaults to generating a
  """

  def generate(timestamp) when is_integer(timestamp) do
    generate_ulid(timestamp, :string)
  end

  def generate(type) when is_atom(type) and type in [:string, :binary] do
    generate_ulid(System.system_time(:millisecond), type)
  end

  def generate(timestamp, type) when is_integer(timestamp) and type in [:string, :binary] do
    generate_ulid(timestamp, type)
  end

  def decode(ulid, type \\ :binary)
      when is_bitstring(ulid) and type in [:binary, :timestamp, :tuple] do
    decoded = decode32_crockford(ulid)

    <<timestamp::unsigned-48, rand::binary>> = decoded

    case type do
      :binary -> decoded
      :timestamp -> timestamp
      :tuple -> {timestamp, rand}
    end
  end

  defp generate_ulid(timestamp, type) when type == :binary do
    <<timestamp::unsigned-48, :crypto.strong_rand_bytes(10)::binary>>
  end

  defp generate_ulid(timestamp, type) when type == :string do
    bytes = generate_ulid(timestamp, :binary)
    encode32_crockford(<<@padding, bytes::binary>>)
  end

  defp encode32_crockford(binary, acc \\ <<>>)

  defp encode32_crockford(<<char_index::unsigned-size(5), rest::bitstring>>, acc) do
    char = String.at(@cf_alphabet, char_index)
    encode32_crockford(rest, acc <> char)
  end

  defp encode32_crockford(<<>>, acc), do: acc

  defp decode32_crockford(encoded) do
    encoded
    |> String.to_charlist()
    |> Enum.reduce(<<>>, fn char, acc ->
      decoded = char_to_int(char)

      <<acc::bitstring, decoded::5>>
    end)
    |> then(fn <<@padding, decoded::binary>> -> decoded end)
  end

  defp char_to_int(char) do
    case char do
      ?0 -> 0
      ?1 -> 1
      ?2 -> 2
      ?3 -> 3
      ?4 -> 4
      ?5 -> 5
      ?6 -> 6
      ?7 -> 7
      ?8 -> 8
      ?9 -> 9
      ?A -> 10
      ?B -> 11
      ?C -> 12
      ?D -> 13
      ?E -> 14
      ?F -> 15
      ?G -> 16
      ?H -> 17
      ?J -> 18
      ?K -> 19
      ?M -> 20
      ?N -> 21
      ?P -> 22
      ?Q -> 23
      ?R -> 24
      ?S -> 25
      ?T -> 26
      ?V -> 27
      ?W -> 28
      ?X -> 29
      ?Y -> 30
      ?Z -> 31
    end
  end
end
