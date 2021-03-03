defmodule CoordTest do
  use ExUnit.Case
  doctest CoordOps

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
end

