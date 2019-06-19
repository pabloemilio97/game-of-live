defmodule Rules.Conways do
  # Cell rules; may be implemented as a protocol 
  # or anonymous function in the future, imagine
  # passing the function as part of is behaviour :)
  def rules(:alive, count)
      when count < 2,
      do: :dead
  def rules(:alive, count)
      when count == 2
      when count == 3,
      do: :alive
  def rules(:alive, count)
      when count > 3,
      do: :dead
  def rules(:dead, count)
      when count == 3,
      do: :alive
  def rules(life, _count), do: life

end
