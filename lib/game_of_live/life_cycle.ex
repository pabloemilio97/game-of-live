defmodule GameOfLive.LifeCycle do

  alias GameOfLive.Arrangement.Grid
  alias GameOfLive.Cell
  use DynamicSupervisor

  def big_bang(size = {x, y}) do
    coordinates = Grid.big_bang(size)
    names = intertwingle(coordinates)

    Enum.each(names, fn {cell, meta, neighbours} -> 
      start_child(:basic, cell, meta) 
      start_child(:meta, meta, neighbours) 
      # run basic cells
    end)
    
    #Grid.big_bang(x, y)
    #coord_list = Grid.big_bang(xL, yL)
    #Enum.each(coord_list, fn {x, y} -> 
    #  {:ok, pid} = start_child({x, y}) 
    #  neighbours = Grid.grid_adjacency({x, y}, {xL, yL})
    #  neighbours = Enum.map(neighbours, &Grid.to_string/1)
    #  Basic.setup(pid, :dead, neighbours)
    #end)
    #
    #Enum.each(coord_list, fn {x, y} ->
    #  Basic.run(Grid.to_string({x, y}))
    #end)
  end

  defp intertwingle(coordinates) do
    # Can be done as a single map
    coordinate_names = 
      |> Enum.map(&Grid.to_string/1)

    cells = 
      coordinate_names
      |> Enum.map(&Grid.to_tuple/1)

    metabolisms = 
      coordinate_names
      |> Enum.map(&("meta" <> &1))
      |> Enum.map(&String.to_tuple/1)

    neighbours = 
      coordinates
      |> Enum.map(fn coordinate -> 
        Grid.grid_adjacency(coordinate, size)
        |> Enum.map(&Grid.to_string/1)
        |> Enum.map(&Grid.to_tuple/1)
      end)
    
    Enum.zip([cells, metabolisms, neighbours])
  end

  def start_child(name) do
    DynamicSupervisor.start_child(__MODULE__, {Basic, {name, "meta" <> name})
  end 

  def start_link(init_arg) do
    DynamicSupervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  @impl true
  def init(_init_arg) do
    DynamicSupervisor.init(
      strategy: :one_for_one
    )
  end

end
