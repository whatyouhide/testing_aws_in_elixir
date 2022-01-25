defmodule TestingAwsInElixir.MixProject do
  use Mix.Project

  def project do
    [
      app: :testing_aws_in_elixir,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp elixirc_paths(:test), do: ["test/support", "lib"]
  defp elixirc_paths(_env), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:mox, "~> 1.0", only: :test},
      {:ex_aws, "~> 2.2"},
      {:ex_aws_s3, "~> 2.3"},
      {:hackney, "~> 1.18"},
      {:sweet_xml, "~> 0.7.2"},
      {:jason, "~> 1.0"}
    ]
  end
end
