defmodule GameOfLive.Cell.ProtoCell do
  # import GameOfLive.Rules.Conways

  # def init(state = {life, neighbours, intelligence}) do
  #   receive do
  #     {:setup, neighbours} ->
  #       init({life, neighbours, intelligence})

  #     :run ->
  #       send(self(), :look_around)

  #     {:are_you, from} ->
  #       send(from, life)

  #     :look_around ->
  #       life = rules(life, count(neighbours))
  #       :erlang.send_after(intelligence, self(), :look_around)
  #   end

  #   init(state)
  # end

  # defp count(neighbours) do
  #   neighbours
  #   |> Enum.map(fn pid -> are_you(pid) end)
  #   |> Enum.filter(fn life -> life == :alive end)
  #   |> Enum.count()
  # end
end
