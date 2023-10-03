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
defmodule TelemetryHelper do
  @moduledoc """
  Helper functions for seeing all telemetry events.
  Only for use in development.
  """

  def attach_all(function \\ &default_handler_fn/3) do
    # Start the tracer
    :dbg.start()

    # Create tracer
    :dbg.tracer(
      :process,
      {fn
         {_, _, _, {_mod, :execute, [name, measurement, metadata]}}, _n ->
           function.(name, metadata, measurement)

         {_, _, _, {_mod, :span, [name, metadata, span_fun]}}, _n ->
           function.(name, metadata, span_fun)
       end, 0}
    )

    # Trace all processes
    :dbg.p(:all, :c)

    # See all emitted telemetry events
    :dbg.tp(:telemetry, :execute, 3, [])
    :dbg.tp(:telemetry, :span, 3, [])
  end

  def stop do
    # Stop seeing all emitted telemetry events
    :dbg.ctp(:telemetry, :execute, 3)
    :dbg.ctp(:telemetry, :span, 3)

    # Stop tracer
    :dbg.stop_clear()
  end

  defp default_handler_fn(name, metadata, measure_or_fun) do
    # Print out telemetry info
    IO.puts(
      "Telemetry event:#{inspect(name)}\nwith #{inspect(measure_or_fun)} and #{inspect(metadata)}"
    )
  end
end
