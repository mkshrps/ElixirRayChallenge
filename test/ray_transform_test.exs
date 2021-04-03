
defmodule Raytransform do
  use ExUnit.Case
  import Ray
  import CoordOps
  #import Matrix
  import Transforms
  import Sphere

  test " intersect a translated sphere with a ray " do
    r = ray(point(0,0,-5),vector(0,0,1))
    s = sphere() 
    s = set_transform(s,translation(5,0,0))
    xs = intersect(s,r)
    assert length(xs) == 0
  end

 test " intersect a scaled sphere with a ray " do
    r = ray(point(0,0,-5),vector(0,0,1))
    s = sphere() 
    s = set_transform(s,scaling(2,2,2))
    xs = intersect(s,r)
    assert length(xs) == 2
    assert intersect_at(xs,0).t == 3
    assert intersect_at(xs,1).t == 7
  end

end

