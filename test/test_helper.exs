ExUnit.start

Mix.Task.run "ecto.create", ~w(-r WeatherPhoenix.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r WeatherPhoenix.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(WeatherPhoenix.Repo)

