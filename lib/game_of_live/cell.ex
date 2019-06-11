defmodule GameOfLive.Cell do
  use GenServer

  # Genserver callbacks
  def init(state) do
    {:ok, state}
  end

  def handle_call(:are_you, _from, state = {life, _}) do
    {:reply, life, state} 
  end

  def handle_cast(:live, state) do
    send self(), :look_around
    {:noreply, state}
  end

  def handle_info(:look_around, {_, adjacent_cells}) do
    life = Enum.random [:alive, :dead] 
    IO.puts "#{inspect self()}, #{life}"
    :erlang.send_after(1500, self(), :look_around) 
    {:noreply, {life, adjacent_cells}} 
  end

  # Cell API
  def start_link(), do: start_link({:dead, []})
  def start_link(state), do: GenServer.start(__MODULE__, state)
  def are_you(pid), do: GenServer.call(pid, :are_you)
  def live(pid), do: GenServer.cast(pid, :live)

end

