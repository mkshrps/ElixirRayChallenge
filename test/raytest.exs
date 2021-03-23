defmodule Raytest do
  use ExUnit.Case
  import Ray
  import CoordOps

  test "ray_test" do
    r = ray(point(2,3,4),vector(1,0,0))
    assert position(r,0) == point(2,3,4)
    assert position(r,1) == point(3,3,4)
    assert position(r,-1) == point(1,3,4)
    assert position(r,2.5) == point(4.5,3,4)
  end

  test "intersect " do
  r = ray(point(0,0,-5),vector(0,0,1))
  s = sphere()
  xs = intersect(s,r)
  assert  length(xs) == 2
  assert    Enum.at(xs,0) == 4.0
  assert    Enum.at(xs,1) == 6.0 
  end
  test "tangent" do
    r = ray(point(0,0,-5),vector(0,0,1))
    s = sphere()
    xs = intersect(s,r)
    assert  length(xs) == 2
    assert    Enum.at(xs,0) == 4.0
    assert    Enum.at(xs,1) == 6.0 
  end 
end

