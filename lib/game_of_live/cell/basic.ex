defmodule GameOfLive.Cell.Basic do
  def setup(pid, life, neighbours), do: GenServer.cast(pid, {:setup, life, neighbours})
  def run(pid), do: GenServer.cast(pid, :look_around)
  def are_you(pid), do: GenServer.call(pid, :are_you)

  import GameOfLive.Rules.Conways
  use GenServer
  alias GameOfLive.Arrangement.Grid

  def start_link(coor = {_x, _y}) do
    name = Grid.to_string(coor)
    GenServer.start_link(__MODULE__, [], name: name)
  end

  def init(_init_params) do
    state = {:dead, []}
    {:ok, state}
  end

  def handle_cast(:look_around, state) do
    send(self(), :look_around)
    {:noreply, state}
  end

  def handle_cast({:setup, life, neighbours}, {_, _}) do
    {:noreply, {life, neighbours}}
  end

  def handle_call(:are_you, _from, state = {life, _}) do
    {:reply, life, state}
  end

  def handle_info(:look_around, {life, neighbours}) do
    life = rule(life, count(neighbours))
    :erlang.send_after(1500, self(), :look_around)
    IO.puts("Cell #{inspect self()} is #{life}")
    {:noreply, {life, neighbours}}
  end

  defp count(neighbours) do
    neighbours
    |> Enum.map(fn pid -> GenServer.call(pid, :are_you, 15_000) end)
    |> Enum.filter(fn life -> life == :alive end)
    |> Enum.count()
  end
end
