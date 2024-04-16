# Configure IEx shell
IEx.configure(
  history_size: -1,
  colors: [eval_result: [:cyan, :bright]],
  inspect: [
    pretty: true,
    limit: :infinity,
    width: 80
  ]
)

# Put any code here that should be executed when iex is started

# Helper function for conditionally defining modules in this file.
# If the shell process crashes the code in this file will be evaluated again,
# and we don't want to define modules again as it will result in a compiler
# warning.
module_missing = fn module ->
  !function_exported?(module, :__info__, 1)
end

module_exists = fn module ->
  function_exported?(module, :__info__, 1)
end

running_applications = Application.started_applications()

# Applications that need to be loaded by Mix, if Mix is running, in order for
# code in this file to run.
if List.keyfind(running_applications, :mix, 0) do
  Mix.ensure_application!(:wx)
  Mix.ensure_application!(:runtime_tools)
  Mix.ensure_application!(:observer)
end

if module_missing.(ObserverHelper) do
  # https://hexdocs.pm/elixir/debugging.html#observer
  defmodule ObserverHelper do
    def start do
      Application.ensure_all_started(:observer)
      :observer.start()
    end
  end
end

if module_missing.(TelemetryHelper) do
  defmodule TelemetryHelper do
    @moduledoc """
    Helper functions for seeing all telemetry events.
    Only for use in development.
    """

    @doc """
    attach_all/0 prints out all telemetry events received by default.
    Optionally, you can specify a handler function that will be invoked
    with the same three arguments that the `:telemetry.execute/3` and
    `:telemetry.span/3` functions were invoked with.
    """
    def attach_all(function \\ &default_handler_fn/3) do
      # Start the tracer
      :dbg.start()

      # Create tracer process with a function that pattern matches out the three
      # arguments the telemetry calls are made with.
      :dbg.tracer(
        :process,
        {fn
           {_, _, _, {_mod, :execute, [name, measurement, metadata]}}, _state ->
             function.(name, metadata, measurement)

           {_, _, _, {_mod, :span, [name, metadata, span_fun]}}, _state ->
             function.(name, metadata, span_fun)
         end, nil}
      )

      # Trace all processes
      :dbg.p(:all, :c)

      # See all emitted telemetry events
      :dbg.tp(:telemetry, :execute, 3, [])
      :dbg.tp(:telemetry, :span, 3, [])
    end

    def stop do
      # Stop tracer
      :dbg.stop()
    end

    defp default_handler_fn(name, metadata, measure_or_fun) do
      # Print out telemetry info
      IO.puts(
        "Telemetry event:#{inspect(name)}\nwith #{inspect(measure_or_fun)} and #{inspect(metadata)}"
      )
    end
  end
end

if module_missing.(StartupBenchmark) do
  defmodule StartupBenchmark do
    @moduledoc "Code to benchmark application startup"

    @spec benchmark(module()) :: list()
    def benchmark(application) do
      # Fetch a complete list of a dependencies, they should be in the order
      # they need to be started in.
      complete_deps = deps_list(application)

      # Start each application in order, timing the start of each application
      dep_start_times =
        Enum.map(complete_deps, fn app ->
          case :timer.tc(fn -> Application.start(app) end) do
            {time, :ok} -> {time, app}
            # Some dependencies like :kernel will have already been started, we can
            # ignore them
            {time, {:error, {:already_started, _}}} -> {time, app}
            # Raise an exception if we get an non-successful return value
            {_time, error} -> raise(error)
          end
        end)

      # Sort dependencies by start time so slowest application is listed first
      dep_start_times
      |> Enum.sort()
      |> Enum.reverse()
    end

    defp deps_list(app) do
      # Get all dependencies for an app
      deps = Application.spec(app)[:applications]

      complete_deps =
        case deps do
          nil ->
            []

          _deps ->
            # Recursively call to get all sub-dependencies
            Enum.map(deps, fn dep -> deps_list(dep) end)
        end

      # Build a complete list of sub dependencies, with the top level application
      # requiring them listed last, also remove any duplicates
      [complete_deps, [app]]
      |> List.flatten()
      |> Enum.uniq()
    end
  end
end
