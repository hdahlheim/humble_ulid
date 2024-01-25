defmodule HumbleUlid.MixProject do
  use Mix.Project

  @version "0.1.0"
  @github "https://github.com/hdahlheim/humble_ulid"

  def project do
    [
      app: :humble_ulid,
      version: @version,
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      source_url: @github,
      homepage_url: @github,
      description: description(),
      package: package(),
      docs: docs()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.31.1", only: :dev, runtime: false}
    ]
  end

  defp description do
    "Dependency free ULID package."
  end

  defp docs do
    [
      extras: ["README.md", "LICENSE"]
    ]
  end

  defp package() do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => @github}
    ]
  end
end
