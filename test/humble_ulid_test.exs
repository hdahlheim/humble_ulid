defmodule HumbleUlidTest do
  use ExUnit.Case
  doctest HumbleUlid

  test "time part is always encoded the same way" do
    ts =
      DateTime.new!(~D[2024-01-24], ~T[21:42:00], "Etc/UTC")
      |> DateTime.to_unix(:millisecond)

    ulid1 = HumbleUlid.generate(ts)
    ulid2 = HumbleUlid.generate(ts)

    assert String.starts_with?(ulid1, "01HMYPRF20") == true
    assert String.starts_with?(ulid2, "01HMYPRF20") == true

    # ensure random part is diffrent
    assert ulid1 != ulid2
  end

  test "ULIDs are accending" do
    ts1 =
      DateTime.new!(~D[2024-01-24], ~T[21:42:00], "Etc/UTC")
      |> DateTime.to_unix(:millisecond)

    ts2 =
      DateTime.new!(~D[2024-01-24], ~T[21:43:00], "Etc/UTC")
      |> DateTime.to_unix(:millisecond)

    ulid1 = HumbleUlid.generate(ts1)
    ulid2 = HumbleUlid.generate(ts2)

    assert ulid2 > ulid1
  end

  test "ULID as binary is 128 bits long" do
    ulid = HumbleUlid.generate_binary()

    assert bit_size(ulid) == 128
  end

  test "ULID as string is 26 characters long" do
    ulid = HumbleUlid.generate()

    assert String.length(ulid) == 26
  end

  test "highest possible ULID" do
    ulid = HumbleUlid.generate(281_474_976_710_655)

    # only check first 10 characters because we don't mock the RNG
    assert String.starts_with?(ulid, "7ZZZZZZZZZ") == true

    assert_raise(FunctionClauseError, fn ->
      HumbleUlid.generate(281_474_976_710_656)
    end)
  end

  test "decoding is case insensitive" do
    ulid =
      HumbleUlid.generate(1_706_197_673_270)
      |> String.downcase()

    assert HumbleUlid.decode(ulid, :timestamp) == 1_706_197_673_270
  end
end
