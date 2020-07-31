# Bless

![Actions CI](https://github.com/NFIBrokerage/bless/workflows/Actions%20CI/badge.svg)

A mix task for running test suites

## Usage

Define the test suite for bless to run by making a list of tasks and
arguments in your `mix.exs` file. Add a `:test_suite` key to the `project/0`
function like so:

    def project do
      [
        preferred_cli_env: [
          bless: :test
        ],
        ..
        test_suite: [
          compile: ["--warnings-as-errors", "--force"],
          "coveralls.html": [],
          format: ["--check-formatted"],
          credo: []
        ],
        ..
      ]
    end

Then running `mix bless` will run each of those tasks.

## Installation

```elixir
def deps do
  [
    {:bless, "~> 1.0"}
  ]
end
```

Check out the docs here: https://cuatro.hexdocs.pm/bless

<!-- # Generated by Elixir.Gaas.Generators.Simple.Readme -->
