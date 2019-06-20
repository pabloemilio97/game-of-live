defmodule GameOfLive.Arrangement.Grid do
  def grid_adjacency(position, {x, y}) do
    position
    |> calculate_positions()
    |> Enum.filter(fn {px, py} -> px >= 0 and py >= 0 end)
    |> Enum.filter(fn {px, py} -> px <= x and py <= y end)
  end

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
