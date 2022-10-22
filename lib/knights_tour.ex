defmodule KnightsTour do

  alias KnightsTour.Tour
  alias KnightsTour.Display
  
  def main(args) do
    OptionParser.parse(args, strict: [start_x: :integer, start_y: :integer, rows: :integer, columns: :integer, all: :boolean, help: :boolean])
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
    """
    
    Calculates a knight's tour on a user define board.
    If one can be found it'll be displayed in an ascii
    representation of the board with the the jumps
    in the squares. N.B.: the jumps are 0 indexed.
    
    --rows <number of rows> (required)
    --columns <number of columns> (required)
    --all <true|false> defaults to false (optional).
      if set to true it will try to find a tour
      from each square (this is not optimized in terms
      of orientation). If set to true, --start-x and
      --start-y are not needed and ignored if
      provided.
    --start-x <0 indexed x coordinate of the tour start square>
      (required if --all not set or false  
    --start-y <0 indexed x coordinate of the tour start square>
      (required if --all not set or false  
    --help print this description
    
    """
    |> IO.puts
  end
  
  def find_tour_for_each_square(rows, columns) do
    start_time = DateTime.utc_now()
    "" |> IO.puts()
    "started: #{start_time |> DateTime.to_string()}" |> IO.puts()

    for x <- 0..(columns - 1),
        y <- 0..(rows - 1) do
      find_tour_for_square({x, y}, rows, columns)
    end

    "" |> IO.puts()
    "total seconds elapsed: #{DateTime.diff(DateTime.utc_now(), start_time)}" |> IO.puts()
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
