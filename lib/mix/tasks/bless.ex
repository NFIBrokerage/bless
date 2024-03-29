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
  def run(_) do
    Mix.Project.config()
    |> Keyword.get(:bless_suite, Bless.default())
    |> Enum.each(fn {task, args} ->
      IO.ANSI.format([:cyan, "Running #{task} with args #{inspect(args)}"])
      |> IO.puts()

      Mix.Task.run(task |> to_string(), args)
    end)
  end
end

# chaps-ignore-stop
