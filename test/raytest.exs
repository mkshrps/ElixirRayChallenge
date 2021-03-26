defmodule Raytest do
  use ExUnit.Case
  import Ray
  import CoordOps
  import Matrix
  import Transforms

  test " intersect a scaled sphere with a ray " do
    r = ray(point(0,0,-5),vector(0,0,1))
    s = sphere() 
    s = set_transform(s,scaling(2,2,2))
    xs = intersect(s,r)
    assert length(xs) == 2
    IO.inspect(xs)
    assert intersect_at(xs,0).t == 3
    assert intersect_at(xs,1).t == 7
  end

  test "transform a ray" do
    r = ray(point(1,2,3), vector(0,1,0))
    m = translation(3,4,5)
    r2 = transform(r,m)
    assert r2.origin == point(4,6,8)
    assert r2.direction == vector(0,1,0)

  end

  test "scale a ray" do
    r = ray(point(1,2,3), vector(0,1,0))
    m = scaling(2,3,4)
    r2 = transform(r,m)
    assert r2.origin == point(2,6,12)
    assert r2.direction == vector(0,3,0)
  end

  test "sphere now has a default transfom key " do
    s = sphere()
    assert s.transform == identity()
    assert s.origin == point(0,0,0)
    t = translation(2,3,4)
    s = set_transform(s,t)
    assert s.transform == t
  end

  test "hit all positive t" do
    s = sphere()
    i1 = intersection(1, s)
    i2 = intersection(2,s)
    xs = intersections([i2,i1])
    assert hit(xs) ==  i1
  end
  test "hit some negative" do
    s = sphere()
    i1 = intersection(-1, s)
    i2 = intersection(1,s)
    xs = intersections([i2,i1])
    assert hit(xs) ==  i2
  end
   test "hit all negative" do
    s = sphere()
    i1 = intersection(-1, s)
    i2 = intersection(-2,s)
    xs = intersections([i2,i1])
    assert hit(xs) == {:miss,0}
   end

  test "hit always lowest non negative" do
    s = sphere()
    i1 = intersection(5, s)
    i2 = intersection(7,s)
    i3 = intersection(-3,s)
    i4 = intersection(2,s)
    xs = intersections([i1,i2,i3,i4])
    assert hit(xs) == i4
  end
  
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
    assert Enum.at(list_of_s,1).t == 2
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
    assert Enum.at(xs,0).t == 4.0
    assert Enum.at(xs,1).t == 6.0 
    assert Enum.at(xs,0).object == s
    assert Enum.at(xs,1).object == s
  end
 
  test " ray at tangent" do
    r = ray(point(0,1,-5),vector(0,0,1))
    s = sphere()
    xs = intersect(s,r)
    assert length(xs) == 2
    assert Enum.at(xs,0).t == 5.0
    assert Enum.at(xs,1).t == 5.0 
    assert Enum.at(xs,0).object == s
    assert Enum.at(xs,1).object == s
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
    assert Enum.at(xs,0).t == -1.0
    assert Enum.at(xs,1).t == 1.0 
    assert Enum.at(xs,0).object == s
    assert Enum.at(xs,1).object == s
  end
 
  test " sphere behind a ray " do
    r = ray(point(0,0,5),vector(0,0,1))
    s = sphere()
    xs = intersect(s,r)
    assert length(xs) == 2
    assert Enum.at(xs,0).t == -6.0
    assert Enum.at(xs,1).t == -4.0 
    assert Enum.at(xs,0).object == s
    assert Enum.at(xs,1).object == s
  end

end

