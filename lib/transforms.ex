defmodule Transforms do

  import Matrix
  import Math
  @moduledoc """
  Module to define matrix transforms
  """
 
  @doc """
  Create an identity matrix
  """
  def identity() do
    [[1,0,0,0],[0,1,0,0],[0,0,1,0],[0,0,0,1]]
  end

  @doc """
  translate a point along x,y,z axes to new x,y,z world coordinates and return a new translated point
  #Example
  new_point = translate(point(1,1,1),2,3,4)

    iex()> translate(point(1,1,1),2,3,4)
    {3.0, 4.0, 5.0, 1.0}

  """
  def translate(point = {_x,_y,_z,_w},x,y,z) do
    matrix_multiply(point,translation(x,y,z))
  end

  @doc """
  rotate point about the x axis by r radians. Return new rotated point
    
    iex()> rotate_x(point(1,1,1),pi()/4)
    {1.0, 0.0, 1.414214, 1.0}
  """
  def rotate_x(point = {_x,_y,_z,_w},r) do
    {x,y,z,w} =  matrix_multiply(point,rotation_x(r))
    {Float.round(x,6),Float.round(y,6),Float.round(z,6),w}
  end
 
  def rotate_y(point = {_x,_y,_z,_w},r) do
    matrix_multiply(point,rotation_y(r))
  end

  def rotate_z(point = {_x,_y,_z,_w},r) do
    matrix_multiply(point,rotation_z(r))
  end

  def scale(point = {_x,_y,_z,_w},x,y,z) do
    matrix_multiply(point,scaling(x,y,z))
  end

  def shear(point = {_x,_y,_z,_w},xy,xz,yx,yz,zx,zy) do
    matrix_multiply(point,shearing(xy,xz,yx,yz,zx,zy))
  end
  

  @doc """
  Create a translationi transform matrix to translate by x,y,z
  """
  def translation(x,y,z) do
    identity()
     |> matrix_update(0,3,x)
     |> matrix_update(1,3,y)
     |> matrix_update(2,3,z)
#    |> IO.inspect()
  end

  @doc """
  Create a scaling transform matrix to scale by x,y,z values
  """
  def scaling(x,y,z) do
    identity()
     |> matrix_update(0,0,x)
     |> matrix_update(1,1,y)
     |> matrix_update(2,2,z)
#    |> IO.inspect()
  end

  @doc """
  Create a rotation transform matrix to rotate x by r radians
  """
  def rotation_x(r) do
    #pi/4
    sinr = sin(r)
    cosr = cos(r)
    identity()
     |> matrix_update(1,1,cosr)
     |> matrix_update(1,2,-sinr)
     |> matrix_update(2,1,sinr)
     |> matrix_update(2,2,cosr)
#    |> IO.inspect()
  end

  @doc """
  Create a rotation transform matrix to rotate y by r radians
  """
  def rotation_y(r) do
    #pi/4
    sinr = sin(r)
    cosr = cos(r)
    identity()
     |> matrix_update(0,0,cosr)
     |> matrix_update(0,2,sinr)
     |> matrix_update(2,0,-sinr)
     |> matrix_update(2,2,cosr)
#    |> IO.inspect()
  end

  @doc """
  Create a rotation transform matrix to rotate z by r radians
  """
  def rotation_z(r) do
    #pi/4
    sinr = sin(r)
    cosr = cos(r)
    identity()
     |> matrix_update(0,0,cosr)
     |> matrix_update(0,1,-sinr)
     |> matrix_update(1,0,sinr)
     |> matrix_update(1,1,cosr)
#    |> IO.inspect()
  end

  @doc """
  Create a shearing transform matrix

  """
  def shearing(xy,xz,yx,yz,zx,zy) do
    identity()
     |> matrix_update(0,1,xy)
     |> matrix_update(0,2,xz)
     |> matrix_update(1,0,yx)
     |> matrix_update(1,2,yz)
     |> matrix_update(2,0,zx)
     |> matrix_update(2,1,zy)
  end
end
