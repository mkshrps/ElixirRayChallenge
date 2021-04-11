defmodule CoordOps do
@moduledoc """
  A module to provide raytracing primitives, primarily tuples used to represent
  points, vectors and colors. 
  Basic primitive operations add, subtract, multiplt and divide

"""
  import Math
  def is_equal(a,b) do
    a <~> b
  end

  def tuple_equal({x,y,z,_},{x1,y1,z1,_}) do
    x <~> x1 and y <~> y1 and z <~> z1
  end
  @doc """
  """
  def point(x\\0,y\\0,z\\0) do
    {x,y,z,1.0}
  end

  def vector(x\\0,y\\0,z\\0) do
    {x,y,z,0.0}
  end

  def color(r,g,b) do
    {r,g,b}
  end

  # t1,t2 4 ele tuples
  #
  @doc """
  tuple operations for  3 and 4 element tuples
  add 2 tuples
  """
  def add_tuple(t1,t2) do
    do_op(t1,t2,&(&1 + &2))
  end

  def multiply_tuple(t1,t2) do
    do_op(t1,t2,&(&1 * &2))
  end

  def subtract_tuple(t1,t2) do
    do_op(t1,t2,&(&1 - &2))
  end

  def div_tuple(t1,t2) do
    do_op(t1,t2,&(&1 / &2))
  end

  # just pass in the uples and the arithmetic function#
  # performs function f on matching pairs of elements x,x1 y,y1 etc
  # accepts 2 tuples
  # return tuple
  
  # 4 diit for points and vectors
  def do_op({x,y,z,w},{x1,y1,z1,w1},f) do 
    {f.(x,x1),f.(y,y1),f.(z,z1),f.(w,w1)}
  end
  # 3 r,g,b for color ops
  def do_op({x,y,z},{x1,y1,z1},f) do 
    {f.(x,x1),f.(y,y1),f.(z,z1)}
  end
  # 
  def negate({x,y,z,w}) do
    {-x,-y,-z,-w}
  end

  @doc """
  scale_tuple(tuple={x,y,z,w}, scale) :: tuple
  
  multiplies each element of tuple by scale value
  works for 3 and 4 element tuples
  """ 
  def scale_tuple({x,y,z,w}=_v,s) do
    {x*s,y*s,z*s,w*s}
  end

  def scale_tuple({x,y,z}=_v,s) do
    {x*s,y*s,z*s}
  end
  @doc """
  calculates scalar magnitude of a vector
  Example:
  - t =  magnitude(vector(1,1,1))
  """
  def magnitude({x,y,z,w}) do
     sqrt(x*x + y*y + z*z + w*w)
  end

  @doc """
  Normalizes vector to create a unit vector providing direction only
  """ 
  def normalize_vector({x,y,z,w}) do
    v = magnitude({x,y,z,w}) 
    {x/v,y/v,z/v,w/v}

  end
  
  def normalize(v) do
    normalize_vector(v)
  end

  @doc """
  Calculates the dot product of a vector
  dot({x1,y1,z1},{x2,y2,z2}) :: scalar 
  
  dot = {x+y+z,w} = {x1,y1,z1,w1} * {x2,y2,z2,w2}
  """
  def dot(t1,t2) do
    {x,y,z,w} = multiply_tuple(t1,t2)
    x+y+z+w
  end
  @doc """
  Calculate cross product of two vectors
  {(y * z1) - (z * y1),(z * x1) - (x * z1),(x * y1) - (y * x1),w}
  """
  def cross({x,y,z,w},{x1,y1,z1,_w1}) do
    {(y * z1) - (z * y1),(z * x1) - (x * z1),(x * y1) - (y * x1),w}
  end


end
