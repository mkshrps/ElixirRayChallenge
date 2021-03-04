defmodule CoordOps do
  import Math
  def is_equal(a,b) do
    a <~> b
  end

  def tuple_equal({x,y,z,_},{x1,y1,z1,_}) do
    x <~> x1 and y <~> y1 and z <~> z1
  end

  def point({x,y,z}) do
    {x,y,z,1.0}
  end

  def vector({x,y,z}) do
    {x,y,z,0.0}
  end
  
  # t1,t2 4 ele tuples
  #
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
  #
  def do_op({x,y,z,w},{x1,y1,z1,w1},f) do 
    {f.(x,x1),f.(y,y1),f.(z,z1),f.(w,w1)}
  end

  # 
  def negate({x,y,z,w}) do
    {-x,-y,-z,-w}
  end
  
  def scale({x,y,z,w},s) do
    {x*s,y*s,z*s,w*s}
  end

  def magnitude({x,y,z,w}) do
     sqrt(x*x + y*y + z*z + w*w)
  end

  # currently rounding this off to pass test and limit accuracy of magnitude
  # may not be required 
  def normalize_vector({x,y,z,w}) do
    v = magnitude({x,y,z,w}) 
    {x/v,y/v,z/v,w/v}

  end
  # t1,t2 are 4 ele tuples
  def dot(t1,t2) do
    {x,y,z,w} = multiply_tuple(t1,t2)
    x+y+z+w

  end

  def cross({x,y,z,w},{x1,y1,z1,_w1}) do
    {(y * z1) - (z * y1),(z * x1) - (x * z1),(x * y1) - (y * x1),w}
  end


end
