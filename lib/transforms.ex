defmodule Transforms do

  import Matrix
  import Math

  def identity() do
    [[1,0,0,0],[0,1,0,0],[0,0,1,0],[0,0,0,1]]
  end

  def translate(point = {_x,_y,_z,_w},x,y,z) do
    matrix_multiply(point,translation(x,y,z))
  end

  def rotate_x(point = {_x,_y,_z,_w},r) do
    matrix_multiply(point,rotation_x(r))
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

  def translation(x,y,z) do
    identity()
     |> matrix_update(0,3,x)
     |> matrix_update(1,3,y)
     |> matrix_update(2,3,z)
#    |> IO.inspect()
  end

  def scaling(x,y,z) do
    identity()
     |> matrix_update(0,0,x)
     |> matrix_update(1,1,y)
     |> matrix_update(2,2,z)
#    |> IO.inspect()
  end

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
