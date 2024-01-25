defmodule HumbleUlid do
  @moduledoc """
  Documentation for `HumbleUlid`.
  """

  # two bit padding to reach 130 bits
  @padding <<0::2>>

  @doc """
  Generates a new Crockford base32 encoded ULID based on the provided timestamp or the current System Time.
  """
  def generate(timestamp \\ System.system_time(:millisecond)) when is_integer(timestamp) do
    bytes = generate_ulid(timestamp)
    encode_crockford32(<<@padding, bytes::binary>>)
  end

  @doc """
  Generates a new ULID in binary form based on the provided timestamp or the current System Time.
  """
  def generate_binary(timestamp \\ System.system_time(:millisecond)) when is_integer(timestamp) do
    generate_ulid(timestamp)
  end

  def decode(ulid, type \\ :binary)
      when is_bitstring(ulid) and type in [:binary, :timestamp, :tuple] do
    decoded = decode_crockford32(ulid)

    <<timestamp::unsigned-48, rand::binary>> = decoded

    case type do
      :binary -> decoded
      :timestamp -> timestamp
      :tuple -> {timestamp, rand}
    end
  end

  defp generate_ulid(timestamp) do
    <<timestamp::unsigned-48, :crypto.strong_rand_bytes(10)::binary>>
  end

  defp encode_crockford32(
         <<c1::5, c2::5, c3::5, c4::5, c5::5, c6::5, c7::5, c8::5, c9::5, c10::5, c11::5, c12::5,
           c13::5, c14::5, c15::5, c16::5, c17::5, c18::5, c19::5, c20::5, c21::5, c22::5, c23::5,
           c24::5, c25::5, c26::5>>
       ) do
    <<enc(c1), enc(c2), enc(c3), enc(c4), enc(c5), enc(c6), enc(c7), enc(c8), enc(c9), enc(c10),
      enc(c11), enc(c12), enc(c13), enc(c14), enc(c15), enc(c16), enc(c17), enc(c18), enc(c19),
      enc(c20), enc(c21), enc(c22), enc(c23), enc(c24), enc(c25), enc(c26)>>
  end

  defp decode_crockford32(
         <<c1::5, c2::5, c3::5, c4::5, c5::5, c6::5, c7::5, c8::5, c9::5, c10::5, c11::5, c12::5,
           c13::5, c14::5, c15::5, c16::5, c17::5, c18::5, c19::5, c20::5, c21::5, c22::5, c23::5,
           c24::5, c25::5, c26::5>>
       ) do
    <<@padding, decoded::binary>> =
      <<dec(c1), dec(c2), dec(c3), dec(c4), dec(c5), dec(c6), dec(c7), dec(c8), dec(c9), dec(c10),
        dec(c11), dec(c12), dec(c13), dec(c14), dec(c15), dec(c16), dec(c17), dec(c18), dec(c19),
        dec(c20), dec(c21), dec(c22), dec(c23), dec(c24), dec(c25), dec(c26)>>

    decoded
  end

  @compile {:inline, enc: 1}
  defp enc(0), do: ?0
  defp enc(1), do: ?1
  defp enc(2), do: ?2
  defp enc(3), do: ?3
  defp enc(4), do: ?4
  defp enc(5), do: ?5
  defp enc(6), do: ?6
  defp enc(7), do: ?7
  defp enc(8), do: ?8
  defp enc(9), do: ?9
  defp enc(10), do: ?A
  defp enc(11), do: ?B
  defp enc(12), do: ?C
  defp enc(13), do: ?D
  defp enc(14), do: ?E
  defp enc(15), do: ?F
  defp enc(16), do: ?G
  defp enc(17), do: ?H
  defp enc(18), do: ?J
  defp enc(19), do: ?K
  defp enc(20), do: ?M
  defp enc(21), do: ?N
  defp enc(22), do: ?P
  defp enc(23), do: ?Q
  defp enc(24), do: ?R
  defp enc(25), do: ?S
  defp enc(26), do: ?T
  defp enc(27), do: ?V
  defp enc(28), do: ?W
  defp enc(29), do: ?X
  defp enc(30), do: ?Y
  defp enc(31), do: ?Z

  @compile {:inline, dec: 1}
  defp dec(?0), do: 0
  defp dec(?1), do: 1
  defp dec(?2), do: 2
  defp dec(?3), do: 3
  defp dec(?4), do: 4
  defp dec(?5), do: 5
  defp dec(?6), do: 6
  defp dec(?7), do: 7
  defp dec(?8), do: 8
  defp dec(?9), do: 9
  defp dec(?A), do: 10
  defp dec(?B), do: 11
  defp dec(?C), do: 12
  defp dec(?D), do: 13
  defp dec(?E), do: 14
  defp dec(?F), do: 15
  defp dec(?G), do: 16
  defp dec(?H), do: 17
  defp dec(?J), do: 18
  defp dec(?K), do: 19
  defp dec(?M), do: 20
  defp dec(?N), do: 21
  defp dec(?P), do: 22
  defp dec(?Q), do: 23
  defp dec(?R), do: 24
  defp dec(?S), do: 25
  defp dec(?T), do: 26
  defp dec(?V), do: 27
  defp dec(?W), do: 28
  defp dec(?X), do: 29
  defp dec(?Y), do: 30
  defp dec(?Z), do: 31
end
