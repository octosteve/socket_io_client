defmodule SocketIoClient.MixProject do
  use Mix.Project

  def project do
    [
      app: :socket_io_client,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {SocketIoClient.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:gun, "~> 1.3"},
      {:jason, "~> 1.2"},
      {:httpoison, "~> 1.8"},
      {:websockex, "~> 0.4.2"}
    ]
  end
end
