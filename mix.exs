defmodule HeroiconsRender.MixProject do
  use Mix.Project

  @source_url "https://github.com/moss-piglet/heroicons_render"
  @version "0.1.2"

  def project do
    [
      app: :heroicons_render,
      version: @version,
      elixir: "~> 1.12",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      docs: docs(),
      aliases: [
        audit: ["format", "credo", "coveralls"]
      ],
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:phoenix, "~> 1.6"},
      {:phoenix_live_view, "~> 0.18"},
      {:jason, "~> 1.0", only: [:dev, :test]},
      {:ex_doc, "~> 0.24", only: :dev, runtime: false},
      {:phoenix_ecto, "~> 4.4"},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.10", only: :test}
    ]
  end

  defp description() do
    """
    Heroicons Render enables rendering V2 heroicons in conjuction with the wonderful Petal Components library.
    """
  end

  defp package do
    [
      name: "heroicons_render",
      maintainers: ["f0rest8"],
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url}
    ]
  end

  defp docs() do
    [
      main: "readme",
      logo: "logo.png",
      name: "Heroicons Render",
      source_ref: "v#{@version}",
      canonical: "http://hexdocs.pm/heroicons_render",
      source_url: @source_url,
      extras: ["README.md"]
    ]
  end
end
