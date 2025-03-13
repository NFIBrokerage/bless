# chaps-ignore-start
defmodule Mix.Tasks.Bless do
  use Mix.Task

  @moduledoc """
  A mix task for running a test suite.

  Define the test suite for bless to run by making a list of tasks and
  arguments in your `mix.exs` file. Add a `:bless_suite` key to the `project/0`
  function like so:

      def project do
        [
          preferred_cli_env: [
            bless: :test
          ],
          ..
          bless_suite: [
            compile: ["--warnings-as-errors", "--force"],
            "chaps.html": ["--force"],
            format: ["--check-formatted"],
            credo: [],
            "deps.unlock": ["--unused"]
          ],
          ..
        ]
      end

  Then running `mix bless` will run each of those tasks.
  """

  @shortdoc "Runs a testing suite"
  def run(archargs) do
    IO.ANSI.format([
      :cyan,
      :bright,
      "Running bless w/ args #{inspect(archargs)}"
    ])
    |> IO.puts()

    Mix.Project.config()
    |> Keyword.get(:bless_suite, Bless.default())
    |> Enum.each(fn {task, _subargs} = bless_component ->
      args =
        bless_component
        |> Bless.combine_args(archargs)

      IO.ANSI.format([:cyan, "Running #{task} with args #{inspect(args)}"])
      |> IO.puts()

      task
      |> to_string()
      |> Mix.Task.run(args)
    end)
  end
end

# chaps-ignore-stop
