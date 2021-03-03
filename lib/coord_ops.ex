defmodule CoordOps do
  import Math
  def is_equal(a,b) do
    a <~> b
  end

  def coord_equal({x,y,z,_},{x1,y1,z1,_}) do
    x <~> x1 and y <~> y1 and z <~> z1
  end

  def point({x,y,z}) do
    {x,y,z,1.0}
  end

  def vector({x,y,z}) do
    {x,y,z,0.0}
  end

  def negate({x,y,z,w}) do
    {-x,-y,-z,-w}
  end
  
  def add_coord(t1,t2) do
    do_op(t1,t2,&(&1 + &2))
  end

  def multiply_coord(t1,t2) do
    do_op(t1,t2,&(&1 * &2))
  end
  def subtract_coord(t1,t2) do
    do_op(t1,t2,&(&1 - &2))
  end

  def div_coord(t1,t2) do
    do_op(t1,t2,&(&1 / &2))
  end

  # factory function for arithmetic functions on coord tuples
  # just pass in the uples and the arithmetic function#
  def do_op({x,y,z,w},{x1,y1,z1,w1},f) do 
    {f.(x,x1),f.(y,y1),f.(z,z1),f.(w,w1)}
  end

end
