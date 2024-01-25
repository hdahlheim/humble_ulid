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
end
