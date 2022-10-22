defmodule KnightsTour.Display do

  def display_tour(nil, _, _) do
    "none" |> IO.puts()
  end

  def display_tour(tour, rows, columns) do
    {_, tour_order} =
      Enum.reduce(tour, {0, %{}}, fn square, {move, tour_order} ->
        {move + 1, Map.put(tour_order, square, move)}
      end)

    board_string_horizontal_line = get_board_string_horizontal_line(rows, columns)

    board_string_body =
      for row <- (rows - 1)..0,
          column <- 0..(columns - 1) do
        formatted_move_number =
          format_move_number(rows, columns, Map.get(tour_order, {row, column}))

        add_square_to_board_string(
          row,
          column,
          formatted_move_number,
          board_string_horizontal_line
        )
      end
      |> Enum.join()

    (board_string_body <> "\n" <> board_string_horizontal_line) |> IO.puts()
  end

  def add_square_to_board_string(_row, 0, formatted_move_number, board_string_horizontal_line) do
    "\n#{board_string_horizontal_line}\n| #{formatted_move_number} |"
  end

  def add_square_to_board_string(
        _row,
        _column,
        formatted_move_number,
        _board_string_horizontal_line
      ) do
    " #{formatted_move_number} |"
  end

  def get_board_string_horizontal_line(rows, columns) do
    max_number_length =
      (rows * columns)
      |> Integer.to_string()
      |> String.length()

    board_string_horizontal_line_length = columns * (3 + max_number_length) + 1

    String.duplicate("-", board_string_horizontal_line_length)
  end

  def format_move_number(rows, columns, move_number) do
    max_length =
      (rows * columns)
      |> Integer.to_string()
      |> String.length()

    move_number_string = Integer.to_string(move_number)
    move_number_length = String.length(move_number_string)

    padding_length = max_length - move_number_length

    "#{String.duplicate(" ", padding_length)}" <> move_number_string
  end
end
