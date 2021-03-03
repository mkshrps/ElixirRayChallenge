defmodule CoordTest do
  use ExUnit.Case
  doctest CoordOps
  import Math

  test "is a vector" do
    assert CoordOps.vector({1,2,3}) == {1,2,3,0.0}
  end
  
  test "is a point" do
    assert CoordOps.point({1,2,3}) == {1,2,3,1.0}
  end

  test "adding point to a vector" do
    assert CoordOps.add_coord({3,-2,5,1},{-2,3,1,0}) == {1,1,6,1}
  end

  test "subtract two points" do
    assert CoordOps.subtract_coord(CoordOps.point({3,2,1}), CoordOps.point({5,6,7})) == CoordOps.vector({-2,-4,-6})
  end

  test "negate tuple" do
    assert CoordOps.negate({1,-2,3,-4}) == {-1,2,-3,4}
  end
  test "magnitude of vector " do
    assert CoordOps.magnitude({1,0,0}) == 1
    assert CoordOps.magnitude({0,1,0}) == 1
    assert CoordOps.magnitude({0,0,1}) == 1
    assert CoordOps.magnitude({1,2,3}) == sqrt(14)
    assert CoordOps.magnitude({-1,-2,-3}) == sqrt(14)
  end
  test "scale tuple" do
    assert CoordOps.scale({1,-2,3,-4},3.5) == {3.5,-7,10.5,-14}
    assert CoordOps.scale({1,-2,3,-4},0.5) == {0.5,-1,1.5,-2}
  end
end


