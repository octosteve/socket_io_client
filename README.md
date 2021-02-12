# SocketIoClient

Implementation of Socket.IO Protocol v5: https://github.com/socketio/socket.io-protocol#protocol-version

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `socket_io_client` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:socket_io_client, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/socket_io_client](https://hexdocs.pm/socket_io_client).

# Usage

{:ok, socket} = Socket.connect("/admin") => # connects to Websocket at /admin, sends
{
  "type": 0,
  "nsp": "/admin",
  "data": {
    "token": "123"
  }
}
