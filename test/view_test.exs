defmodule ViewTest do
  use ExUnit.Case
  import CoordOps
  import Transforms
  import Utils
  import View_transform

  def mat1() do
    [
      [-0.50709,0.50709,0.67612,-2.36643],
      [0.76772,0.60609,0.12122,-2.82843],
      [-0.35857,0.59761,-0.71714,0.00000],
      [0.00000,0.00000,0.00000,1.00000]]
  end

  test "transform matrix for ddefault orientation" do
    from = point(0,0,0)
    to = point(0,0,-1)
    up = vector(0,1,0)
    t = view_transform(from,to,up)
    assert  t == identity() 
  end
  test "view transform matrix in positive Z" do
    from = point(0,0,0)
    to = point(0,0,1)
    up = vector(0,1,0)
    t = view_transform(from,to,up)
    assert  t == scaling(-1,1,-1)
  end
 test "view transform moves the world" do
    from = point(0,0,8)
    to = point(0,0,0)
    up = vector(0,1,0)
    t = view_transform(from,to,up)
    assert  t == translation(0,0,-8)
  end

  test "arbitary view transform" do
    from = point(1,3,2)
    to = point(4,-2,8)
    up = vector(1,1,0)
    t = view_transform(from,to,up)
    assert trim_matrix(t,5) == mat1()
  end

end

