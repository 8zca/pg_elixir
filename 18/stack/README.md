# Stack

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `stack` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:stack, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/stack](https://hexdocs.pm/stack).

## deploy
exrmではなくdistilleryを利用します。
https://hexdocs.pm/distillery/introduction/installation.html

```
mix distillery.init
```

config/config.exsを作成（とくに何も設定しないため空ファイル）

```
mix distillery.release
```

本番用は
```
MIX_ENV=prod mix distillery.release


$ ls -lh _build/prod/rel/stack/releases/0.1.0/stack.tar.gz 
-rw-r--r--  1 kmoriwak  staff    12M  3  2 18:53 _build/prod/rel/stack/releases/0.1.0/stack.tar.gz
```