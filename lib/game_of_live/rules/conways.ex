defmodule GameOfLive.Rules.Conways do
  @behaviour GameOfLive.Rules

  def rule(:alive, count)
      when count < 2,
      do: :dead

  def rule(:alive, count)
      when count == 2
      when count == 3,
      do: :alive

  def rule(:alive, count)
      when count > 3,
      do: :dead

  def rule(:dead, count)
      when count == 3,
      do: :alive

  def rule(life, _count), do: life
end
