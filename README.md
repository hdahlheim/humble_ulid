# HumbleUlid

Yet another ULID library mainly intended for use in other Humble packages.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `humble_ulid` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:humble_ulid, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/humble_ulid>.

## License

Copyright (c) 2024 Henning Dahlheim

Distributed under the [MIT License](LICENSE).

## Why yet another ULID package?

I noticed that the other ULID packages were causing warnings during compilation and
haven't been published to Hex in a while. Instead of opening issues asking for a
new release, I wanted to implement it myself as an exercise with the option to change
the API to my needs.

This package aims to be dependency free.

I'll try to keep this implementation up to date with new versions of Elixir.

## References

[ULID spec](https://github.com/ulid/spec)
[Ecto.ULID](https://github.com/TheRealReal/ecto-ulid)
