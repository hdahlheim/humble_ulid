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
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  defp description do
    "Dependency free ULID package."
  end

  defp docs do
    [
      main: "README",
      extras: ["README.md"]
    ]
  end

  defp package() do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => @github}
    ]
  end
end
