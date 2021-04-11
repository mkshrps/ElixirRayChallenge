defmodule View_transform do
  import CoordOps
  import Matrix
  import Transforms

  def view_transform(from,to,up) do
    forward = forward(from,to)
    left = left(forward,up)
    true_up = true_up(left, forward)
    orientation = create_view(left,forward,true_up) 
    translate_orientation(orientation,from)
  end

  def forward(from,to) do
    subtract_tuple(to,from)
    |> normalize()
  end

  def left(forward,up) do
    cross(forward,normalize(up))
  end

  def true_up(left,forward) do
    cross(left,forward)
  end

  def create_view(left,forward,true_up) do
    {forward_x,forward_y,forward_z,_} = forward
    {left_x,left_y,left_z,_} = left
    {true_up_x,true_up_y,true_up_z,_} = true_up
    [
      [left_x,left_y,left_z,0],
      [true_up_x,true_up_y,true_up_z,0],
      [-forward_x,-forward_y,-forward_z,0],
      [0,0,0,1]
    ]
  end

  def translate_orientation(orientation,{from_x,from_y,from_z,_}) do
    matrix_multiply(
      orientation,
      translation(-from_x,-from_y,-from_z)
    )
  end
  
end


