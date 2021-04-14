defmodule Bless do
  @moduledoc """
  A mix task for running test suites
  """

  def default do
    [
      compile: ["--warnings-as-errors", "--force"],
      "coveralls.html": ["--raise"],
      format: ["--check-formatted"],
      credo: []
    ]
    |> append_version_dependent_checks()
  end

  defp append_version_dependent_checks(checks) do
    version_dependent_checks =
      if Version.match?(System.version(), "~> 1.10") do
        [
          "deps.unlock": ["--check-unused"]
        ]
      else
        []
      end

    checks ++ version_dependent_checks
  end
end
