defmodule Bless do
  @moduledoc """
  A mix task for running test suites
  """

  def default do
    [
      compile: ["--warnings-as-errors", "--force"],
      "chaps.html": ["--raise"],
      "coveralls.html": ["--raise"],
      format: ["--check-formatted"],
      credo: [],
      "deps.unlock": ["--check-unused"]
    ]
    |> Enum.filter(&available?/1)
  end

  # chaps-ignore-start
  defp available?({:chaps, _args}),
    do: Code.ensure_loaded?(Mix.Tasks.Chaps.Html)

  defp available?({:coveralls, _args}),
    do: Code.ensure_loaded?(Mix.Tasks.Coveralls.Html)

  # chaps-ignore-stop
  defp available?({:"chaps.html", _args}),
    do: Code.ensure_loaded?(Mix.Tasks.Chaps.Html)

  defp available?({:"coveralls.html", _args}),
    do: Code.ensure_loaded?(Mix.Tasks.Coveralls.Html)

  defp available?({:format, _args}),
    do: Code.ensure_loaded?(Mix.Tasks.Coveralls.Html)

  defp available?({:"deps.unlock", args}) do
    if "--check-unused" in args,
      do: Version.match?(System.version(), "~> 1.10"),
      else: true
  end

  defp available?(_check), do: true
end
