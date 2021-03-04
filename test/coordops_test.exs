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
    assert CoordOps.add_tuple({3,-2,5,1},{-2,3,1,0}) == {1,1,6,1}
  end

  test "subtract two points" do
    assert CoordOps.subtract_tuple(CoordOps.point({3,2,1}), CoordOps.point({5,6,7})) == CoordOps.vector({-2,-4,-6})
  end

  test "negate tuple" do
    assert CoordOps.negate({1,-2,3,-4}) == {-1,2,-3,4}
  end
  test "magnitude of vector " do
    assert CoordOps.magnitude({1,0,0,0}) == 1
    assert CoordOps.magnitude({0,1,0,0}) == 1
    assert CoordOps.magnitude({0,0,1,0}) == 1
    assert CoordOps.magnitude({1,2,3,0}) == sqrt(14)
    assert CoordOps.magnitude({-1,-2,-3,0}) == sqrt(14)
  end

  test "scale tuple" do
    assert CoordOps.scale({1,-2,3,-4},3.5) == {3.5,-7,10.5,-14}
    assert CoordOps.scale({1,-2,3,-4},0.5) == {0.5,-1,1.5,-2}
  end
  test "normalize vector" do
#    assert CoordOps.normalize_vector(CoordOps.vector{1,2,3}) == CoordOps.vector({0.26726,0.53452,0.80178})
    assert CoordOps.normalize_vector(CoordOps.vector{4,0,0}) == CoordOps.vector({1,0,0})
    norm =  CoordOps.normalize_vector(CoordOps.vector{1,2,3})
    assert CoordOps.magnitude(norm) == 1.0
  end

  test "dot product multiply and add elemnts of 2 tuples" do
    assert CoordOps.dot(CoordOps.vector({1,2,3}),CoordOps.vector({2,3,4})) == 20
  end

  test "cross product multiply and add elemnts of 2 tuples" do
    assert CoordOps.cross({1,2,3,0},{2,3,4,0}) == {-1,2,-1,0}
    assert CoordOps.cross({2,3,4,0},{1,2,3,0}) == {1,-2,1,0}
  end

end

