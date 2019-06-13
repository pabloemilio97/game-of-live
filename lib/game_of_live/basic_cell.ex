defmodule GameOfLive.BasicCell do
  use GenServer

  # Genserver callbacks
  def init(state) do
    {:ok, state}
  end

  def handle_cast({:setup, neighbours}, {life, _}) do
    {:noreply, {life, neighbours}}
  end

  def handle_cast(:run, state) do
    send(self(), :look_around)
    {:noreply, state}
  end

  def handle_call(:are_you, _from, state = {life, _}) do
    {:reply, life, state}
  end

  def handle_info(:look_around, {life, neighbours}) do
    life = rules(life, count(neighbours))
    IO.puts("#{inspect(self())}, #{life}")
    :erlang.send_after(1500, self(), :look_around)
    {:noreply, {life, neighbours}}
  end

  # Cell API
  def start_link(life), do: GenServer.start(__MODULE__, {life, []})
  def setup(pid, neighbours), do: GenServer.cast(pid, {:setup, [neighbours]})
  def run(pid), do: GenServer.cast(pid, :run)
  def are_you(pid), do: GenServer.call(pid, :are_you)


  defp count(neighbours) do
      neighbours
      |> Enum.map(fn pid -> are_you(pid) end)
      |> Enum.filter(fn life -> life == :alive end)
      |> Enum.count()
  end

  # Cell rules; may be implemented as a protocol 
  # or anonymous function in the future, imagine
  # passing the function as part of is behaviour :)
  defp rules(:live, count)
       when count < 2,
       do: :dead
  defp rules(:live, count)
       when count == 2
       when count == 3,
       do: :alive
  defp rules(:live, count)
       when count > 3,
       do: :dead
  defp rules(:dead, count)
       when count == 3,
       do: :alive
  defp rules(life, _count), do: life
       do: life
end

