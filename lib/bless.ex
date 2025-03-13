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

  @option_definitions [seed: :string]
  @option_mappings [seed: [:test, :"chaps.html", :"coveralls.html"]]
  def combine_args({task, subargs} = _bless_component, archargs) do
    {parsed_args, _other_args, _invalid_args} =
      OptionParser.parse(archargs, strict: @option_definitions)

    parsed_args
    |> Enum.filter(fn {switch, _val} ->
      task in Keyword.get(@option_mappings, switch)
    end)
    |> OptionParser.to_argv()
    |> Kernel.++(subargs)
  end

  # chaps-ignore-start
  defp available?({:chaps, _args}),
    do: Code.ensure_loaded?(Mix.Tasks.Chaps)

  defp available?({:coveralls, _args}),
    do: Code.ensure_loaded?(Mix.Tasks.Coveralls)

  # chaps-ignore-stop
  defp available?({:"chaps.html", _args}),
    do: Code.ensure_loaded?(Mix.Tasks.Chaps.Html)

  defp available?({:"coveralls.html", _args}),
    do: Code.ensure_loaded?(Mix.Tasks.Coveralls.Html)

  defp available?({:credo, _args}),
    do: Code.ensure_loaded?(Mix.Tasks.Credo)

  defp available?({:format, _args}),
    do: Code.ensure_loaded?(Mix.Tasks.Format)

  defp available?({:"deps.unlock", args}) do
    if "--check-unused" in args,
      do: Version.match?(System.version(), "~> 1.10"),
      else: true
  end

  defp available?(_check), do: true
end
