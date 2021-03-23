defmodule Raytest do
  use ExUnit.Case
  import Ray
  import CoordOps
  
  test "intersection" do
    s = sphere()
    i = intersection(3.5,s)
    assert i.t == 3.5
    assert i.object == s
  end

  test "intersection list" do
    s = sphere()
    i1 = intersection(1,s)
    i2 = intersection(2,s)
    list_of_s = intersections([],[i1,i2])
    assert Enum.at(list_of_s,0).t == 1
    assert Enum.at(list_of_s,0).object == s
    assert Enum.at(list_of_s,1).t == 2
    assert Enum.at(list_of_s,1).object == s
  end


  test "ray_test" do
    r = ray(point(2,3,4),vector(1,0,0))
    assert position(r,0) == point(2,3,4)
    assert position(r,1) == point(3,3,4)
    assert position(r,-1) == point(1,3,4)
    assert position(r,2.5) == point(4.5,3,4)
  end

  test " ray intersection " do
    r = ray(point(0,0,-5),vector(0,0,1))
    s = sphere()
    xs = intersect(s,r)
    assert length(xs) == 2
    assert Enum.at(xs,0) == 4.0
    assert Enum.at(xs,1) == 6.0 
  end
 
  test " ray at tangent" do
    r = ray(point(0,1,-5),vector(0,0,1))
    s = sphere()
    xs = intersect(s,r)
    assert length(xs) == 2
    assert Enum.at(xs,0) == 5.0
    assert Enum.at(xs,1) == 5.0 
  end

 test " ray misses a sphere " do
    r = ray(point(0,2,-5),vector(0,0,1))
    s = sphere()
    xs = intersect(s,r)
    assert length(xs) == 0
  end

 test " ray inside a sphere " do
    r = ray(point(0,0,0),vector(0,0,1))
    s = sphere()
    xs = intersect(s,r)
    assert length(xs) == 2
    assert Enum.at(xs,0) == -1.0
    assert Enum.at(xs,1) == 1.0 
  end
 
  test " sphere behind a ray " do
    r = ray(point(0,0,5),vector(0,0,1))
    s = sphere()
    xs = intersect(s,r)
    assert length(xs) == 2
    assert Enum.at(xs,0) == -6.0
    assert Enum.at(xs,1) == -4.0 
  end

end

