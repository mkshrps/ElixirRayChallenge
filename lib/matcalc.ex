defmodule Matcalc do
  import Math

  def is_equal(a,b) do
    a <~> b
  end

  def coord_is_equal([x,y,z,_],[x1,y1,z1,_]) do
    x <~> x1 and y <~> y1 and z <~> z1
    
  end

  def point(p) do
    p ++ [1]
  end

  def vector(p) do
    p ++ [0]
  end

  def multiply_points(list1,list2) do
    process_points(list1,list2,&(&1*&2))
  end

  def add_points(list1,list2) do
    process_points(list1,list2,&(&1+&2))
  end

  def subtract_points(list1,list2) do
    process_points(list1,list2,&(&1-&2))
  end

  def div_points(list1,list2) do
    process_points(list1,list2,&(&1/&2))
  end

  # let's generically process two lists (points or vectors) together recursively
  #
  def process_points([],[],_f) do
   [] 
  end

  def process_points([v1|point1],[v2|point2],f) do
    [f.(v1,v2)|process_points(point1,point2,f)]
  end

end 
