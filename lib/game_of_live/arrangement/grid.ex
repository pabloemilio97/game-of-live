defmodule GameOfLive.Arrangement.Grid do

  def big_bang({x, y}) do
    for u <- 1..x, v <- 1..y do
      {x, y}
    end
  end

  def grid_adjacency(position = {_x, _y}, {x, y}) do
    position
    |> calculate_positions()
    |> Enum.filter(fn {px, py} -> px >= 1 and py >= 1 end)
    |> Enum.filter(fn {px, py} -> px <= x and py <= y end)
  end

  def to_string({x, y}), do: "{#{x},#{y}}"
  
  defp calculate_positions({x, y}) do
    [
      {x - 1, y - 1},
      {x + 0, y - 1},
      {x + 1, y - 1},
      {x - 1, y + 0},
      {x + 1, y + 0},
      {x - 1, y + 1},
      {x + 0, y + 1},
      {x + 1, y + 1}
    ]
  end
end
