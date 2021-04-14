defmodule Bless do
  @moduledoc """
  A mix task for running test suites
  """

  def default do
    [
      compile: ["--warnings-as-errors", "--force"],
      "coveralls.html": ["--raise"],
      format: ["--check-formatted"],
      credo: [],
      "deps.unlock": ["--check-unused"]
    ]
  end
end
