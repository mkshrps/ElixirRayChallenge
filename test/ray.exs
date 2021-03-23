defmodule Raytest do
  use ExUnit.Case
  doctest Raytest
  import Ray
  import CoordOps

  test "ray_test" do
    r = ray(point(2,3,4),vector(1,0,0))
    assert position(r,0) == point(2,3,4)
    assert position(r,1) == point(3,3,4)
    assert position(r,-1) == point(1,3,4)
    assert position(r,2.5) == point(4.5,3,4)
  end
end

