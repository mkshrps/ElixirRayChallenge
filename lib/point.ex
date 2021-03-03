defmodule Coord do

@moduledoc """

  Coord type x,y,z,w
  w determines if point (w=0.0) or vextor (w=1.0)

  initially coordinates will be created as a Coord struct thus ensuring x,y,z,w
  params assigned correctly
"""

  defstruct x: 0.0,y: 0.0, z: 0.0, w: 0.0
  
  def is_point(coord) when coord.w == 1.0, do: false
  def is_point(coord) when coord.w == 0.0, do: true

   
  def to_map(coord) do
    Map.from_struct(coord)
  end
  # to_list(Coord)  returns a list of numeric w,x,y,z values for calculations
  #
  def to_list(coord = %Coord{}) do
    [coord.w,coord.x,coord.y,coord.z]
  end
  

  def to_list(_) do
    [error: "not a Coord struct"]
  end

  def to_coord([w,x,y,z]) do # [w,x,y,z]
    coord = %Coord{}
    %Coord{coord | w: w, x: x, y: y, z: z}
#    %Coord{ w: w, x: x, y: y, z: z}
  end


  def make_point(coord ) do
    %Coord{coord | w: 0.0}
  end
  
  def make_vector(coord ) do
    %Coord{coord | w: 1.0}
  end
  
  def set_x(coord,x) do
    %Coord{coord | x: x}
  end
  
  def set_y(coord,y) do
    %Coord{coord | y: y}
  end
 
  def set_z(coord,z) do
    %Coord{coord | z: z}
  end
  
  def set_all(coord,x,y,z) do
    %Coord{coord | x: x,y: y,z: z}
  end
end

