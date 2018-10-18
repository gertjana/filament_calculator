defmodule Filament.Mixfile do
  use Mix.Project

  def project do
    [
      app: :filament,
      escript: [main_module: Filament.CLI],
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: {Filament, []}, 
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_cli, "~> 0.1.0"},
      {:poison, "~> 3.1"},
      {:scribe, "~> 0.8"}
    ]
  end
end
