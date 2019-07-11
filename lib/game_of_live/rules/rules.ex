defmodule GameOfLive.Rules do
  @type state :: :alive | :dead

  @callback rule(state, non_neg_integer()) :: state
end
