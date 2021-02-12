defmodule SocketIoClient.EventTest do
  use ExUnit.Case
  doctest SocketIoClient

  test "converts connect event to struct" do
    event = SocketIoClient.Event.new() == :world
  end
end
