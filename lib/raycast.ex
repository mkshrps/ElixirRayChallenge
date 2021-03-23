defmodule Ray do
  import CoordOps
 # @type ray_type() :: %{origin: tuple(), direction: tuple()}
  
  def ray(origin \\ point(0,0,0),direction \\ vector(0,0,0)) do
    %{origin: origin, direction: direction}
  end
# @spec position(ray_type(),number()) :: tuple() 
  def position(r,scale_value) do
    scale_tuple(r.direction , scale_value)
    |> add_tuple(r.origin)
  end

  def sphere, do: spawn fn -> 1+2 end

end

