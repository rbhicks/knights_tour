defmodule KnightsTour.Tour do
  def tour(starting_square, rows, columns) do
    tour([starting_square], [get_possible_moves(starting_square, rows, columns)], rows, columns)
  end

  defp tour(path, _possible_moves, rows, columns) when length(path) == rows * columns do
    path |> Enum.reverse()
  end

  defp tour(_, [], _, _) do
    nil
  end

  defp tour(
        [_head_path | tail_path],
        [[] | tail_possible_moves],
        rows,
        columns
      ) do
    tour(tail_path, tail_possible_moves, rows, columns)
  end

  defp tour(
        path,
        [[head_head_possible_moves | tail_head_possible_moves] | tail_possible_moves],
        rows,
        columns
      ) do
    updated_path = [head_head_possible_moves | path]

    updated_possible_moves = [
      head_head_possible_moves
      |> get_possible_moves(rows, columns)
      |> Enum.reject(fn square ->
        Enum.any?(updated_path, fn visited_square ->
          square == visited_square
        end)
      end)
      | [tail_head_possible_moves | tail_possible_moves]
    ]

    tour(updated_path, updated_possible_moves, rows, columns)
  end

  defp get_possible_moves({x, y}, rows, columns) do
    [
      {x + 2, y + 1},
      {x + 1, y + 2},
      {x - 1, y + 2},
      {x - 2, y + 1},
      {x - 2, y - 1},
      {x - 1, y - 2},
      {x + 1, y - 2},
      {x + 2, y - 1}
    ]
    |> Enum.filter(fn coordinates -> filter_impossible_moves(coordinates, rows, columns) end)
  end

  defp filter_impossible_moves({x, _y}, _rows, _columns) when x < 0, do: false
  defp filter_impossible_moves({x, _y}, _rows, columns) when x > columns - 1, do: false
  defp filter_impossible_moves({_x, y}, _rows, _columns) when y < 0, do: false
  defp filter_impossible_moves({_x, y}, rows, _columns) when y > rows - 1, do: false
  defp filter_impossible_moves(_, _, _), do: true
end
