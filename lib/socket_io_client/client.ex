require IEx

defmodule SocketIo.Client do
  use WebSockex

  def handle_connect(conn, state) do
    {:ok, Map.put(state, :conn, conn)}
  end

  def run do
    %HTTPoison.Response{body: "0" <> response} =
      HTTPoison.get!("http://localhost:4000/socket.io/?EIO=4&t=lksjdlfkdj&transport=polling")

    IO.puts("OPEN packet type")

    %{"sid" => sid} =
      response
      |> Jason.decode!()
      |> IO.inspect()

    IO.puts("POSTING")
    url = "/socket.io/?EIO=4&transport=polling&sid=#{sid}"

    HTTPoison.post!("http://localhost:4000" <> url, "40", [
      {"Content-Type", "text/plain;charset=UTF-8"}
    ])

    HTTPoison.get!("http://localhost:4000" <> url)
    |> IO.inspect()

    ws_url = "/socket.io/?EIO=4&transport=websocket&sid=#{sid}"
    {:ok, socket} = WebSockex.start_link("http://localhost:4000" <> ws_url, __MODULE__, %{})
    WebSockex.send_frame(socket, {:text, "2probe"})
    drain()
  end

  def handle_frame({:text, "3probe"}, state) do
    IO.inspect(state)
    {:reply, {:text, "5"}, state}
  end

  def handle_frame({:text, "2"}, state) do
    IO.puts("Responding to ping")
    {:reply, {:text, "3"}, state}
  end

  def handle_frame({:text, "1"}, state) do
    IO.puts("WHY YOU CLOSE")
    {:reply, {:text, "3"}, state}
  end

  def handle_frame(msg, state) do
    IO.inspect(msg)
    {:ok, state}
  end

  # def run do
  #  {:ok, conn} =
  #    :gun.open('localhost', 4000, %{
  #      http_opts: %{keepalive: :infinity},
  #      http2_opts: %{keepalive: :infinity}
  #    })

  #  {:ok, _protocol} = :gun.await_up(conn, :timer.minutes(1))

  #  :gun.get(conn, '/socket.io/?EIO=4&t=lksjdlfkdj&transport=polling')

  #  sid =
  #    receive do
  #      {:gun_data, _pid, _ref, :fin, "0" <> msg} ->
  #        IO.puts("OPEN packet type")

  #        %{"sid" => sid} =
  #          msg
  #          |> Jason.decode!()
  #          |> IO.inspect()

  #        sid
  #    end

  #  IO.puts("POSTING")
  #  url = '/socket.io/?EIO=4&transport=polling&sid=#{sid}'

  #  headers = [
  #    {"Content-type", "text/plain;charset=UTF-8"}
  #  ]

  #  :gun.post(conn, url, headers, '40')
  #  :gun.get(conn, url, headers)
  #  :gun.ws_upgrade(conn, '/socket.io/?EIO=4&transport=websocket&sid=#{sid}')
  #  drain()
  # end

  def drain() do
    receive do
      msg ->
        IO.inspect(msg)

        drain()
    after
      5_000 -> :ok
    end
  end
end
