defmodule SocketIoClientTest do
  use ExUnit.Case
  doctest SocketIoClient

  test "greets the world" do
    assert SocketIoClient.hello() == :world
  end
end
