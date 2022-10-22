defmodule KnightsTour do

  alias KnightsTour.Tour
  alias KnightsTour.Display
  
  def main(args) do
    OptionParser.parse(args, strict: [start_x: :integer, start_y: :integer, rows: :integer, columns: :integer, all: :boolean, help: :boolean])
    |> IO.inspect(limit: :infinity)
    |> elem(0)
    |> Enum.into(%{})
    |> tour_for_args
  end

  def tour_for_args(%{help: true}) do
    display_help()
  end

  def tour_for_args(%{start_x: start_x, start_y: start_y, rows: rows, columns: columns}) do
    find_tour_for_square({start_x, start_y}, rows, columns)
  end
  
  def tour_for_args(%{rows: rows, columns: columns, all: true}) do
    find_tour_for_each_square(rows, columns)
  end

  def tour_for_args(%{}) do
    display_help()
  end

  def display_help do
    "help stuff" |> IO.puts
  end
  
  def find_tour_for_each_square(rows, columns) do
    start_time = DateTime.utc_now()
    "" |> IO.puts()
    "started: #{start_time |> DateTime.to_string()}" |> IO.puts()

    for x <- 0..(columns - 1),
        y <- 0..(rows - 1) do
      find_tour_for_square({x, y}, rows, columns)
    end

    "seconds elapsed: #{DateTime.diff(DateTime.utc_now(), start_time)}" |> IO.puts()
  end

  def find_tour_for_square({x, y}, rows, columns) do
    tour_start_time = DateTime.utc_now()
    "" |> IO.puts()
    "starting square #{x}, #{y}:" |> IO.puts()

    Tour.tour({x, y}, rows, columns)
    |> Display.display_tour(rows, columns)

    "" |> IO.puts()

    "seconds elapsed for this starting square: #{DateTime.diff(DateTime.utc_now(), tour_start_time)}"
    |> IO.puts()
  end
end
