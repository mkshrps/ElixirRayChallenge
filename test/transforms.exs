defmodule Tranformtest do
  use ExUnit.Case
  import Matrix
  import CoordOps
  import Transforms
  import Math

   test "test translation transforms" do
     # translation test
     transform = translation(5,-3,2)
     p = point(-3,4,5)
     assert matrix_multiply(transform,p) == point(2,1,7)

     # inverse of translation moves in opposite direction
     transform = translation(5,-3,2)
     inv = invert(transform)
     p = point(-3,4,5)
     assert matrix_multiply(inv,p) == point(-8,7,3)

    # translation does not affect vectors     
    transform = translation(5,-3,2)
     v = vector(-3,4,5)
     assert matrix_multiply(transform,v) == v
   end 

   test "test scaling transforms" do
     transform = scaling(2,3,4)
     p = point(-4,6,8)
     assert matrix_multiply(transform,p) == point(-8,18,32)

     transform = scaling(2,3,4)
     v = vector(-4,6,8)
     assert matrix_multiply(transform,v) == vector(-8,18,32)

     transform = scaling(2,3,4)
     inv = invert(transform)
     v = vector(-4,6,8)
     assert matrix_equal?( matrix_multiply(inv,v),vector(-2,2,2)) == true

     transform = scaling(-1,1,1)
     p = point(2,3,4)
     assert matrix_multiply(transform,p) == point(-2,3,4)


   end

   test "test x rotaion" do
     p = point(0,1,0)
     half_quarter = rotation_x(pi() / 4)
     full_quarter = rotation_x(pi() / 2)
     assert matrix_equal?(
       matrix_multiply(half_quarter,p),point(0,sqrt(2)/2, sqrt(2)/2)
     )

      assert matrix_equal?(
       matrix_multiply(full_quarter,p),point(0,0,1)
     )
   
     assert matrix_equal?(
      rotate_x(p,pi()/4),point(0,sqrt(2)/2, sqrt(2)/2)
     )

     assert matrix_equal?(
      rotate_x(p,pi()/2),point(0,0,1)
     )
 
     p = point(0,1,0)
     half_quarter = rotation_x(pi() / 4)
     inv = invert(half_quarter)
     assert matrix_equal?(
       matrix_multiply(inv,p),point(0,sqrt(2)/2, -sqrt(2)/2)
     )
   end

   test "test y rotaion" do
     p = point(0,0,1)
     half_quarter = rotation_y(pi() / 4)
     full_quarter = rotation_y(pi() / 2)
     assert matrix_equal?(
       matrix_multiply(half_quarter,p),point(sqrt(2)/2,0,sqrt(2)/2)
     )

     assert matrix_equal?(
       matrix_multiply(full_quarter,p),point(1,0,0)
     )

     assert matrix_equal?(
      rotate_y(p,pi()/2),point(1,0,0)
     )
   end

   test "test z rotaion" do
     p = point(0,1,0)
     half_quarter = rotation_z(pi() / 4)
     full_quarter = rotation_z(pi() / 2)
     assert matrix_equal?(
       matrix_multiply(half_quarter,p),point(-sqrt(2)/2,sqrt(2)/2,0)
     )

     assert matrix_equal?(
       matrix_multiply(full_quarter,p),point(-1,0,0)
     )

      assert matrix_equal?(
      rotate_z(p,pi()/2),point(-1,0,0)
     )
   end


   test "test shearing x-y " do
     p = point(2,3,4)
     assert shear(p,1,0,0,0,0,0) == point(5,3,4)
   end

   test "test shearing x-z " do
     transform = shearing(0,1,0,0,0,0)
     p = point(2,3,4)
     assert matrix_multiply(transform,p) == point(6,3,4)
   end

   test "test shearing y-x " do
     transform = shearing(0,0,1,0,0,0)
     p = point(2,3,4)
     assert matrix_multiply(transform,p) == point(2,5,4)
   end
   
   test "test shearing y-z " do
     transform = shearing(0,0,0,1,0,0)
     p = point(2,3,4)
     assert matrix_multiply(transform,p) == point(2,7,4)
   end
   
   test "test shearing z-x " do
     transform = shearing(0,0,0,0,1,0)
     p = point(2,3,4)
     assert matrix_multiply(transform,p) == point(2,3,6)
   end
   
   test "test shearing z-y " do
     transform = shearing(0,0,0,0,0,1)
     p = point(2,3,4)
     assert matrix_multiply(transform,p) == point(2,3,7)
   end

  test "sequential transforms" do
    p = point(1,0,1)
    p2 = matrix_multiply(rotation_x(pi()/2),p) 
    assert matrix_equal?(p2, point(1,-1,0)) == true
    p3 = matrix_multiply(scaling(5,5,5),p2) 
    assert matrix_equal?(p3,point(5,-5,0)) == true
    assert matrix_equal?(matrix_multiply(translation(10,5,7),p3),point(15,0,7)) == true
  end

  test "piped transforms" do
   result =(
     point(1,0,1)
     |> matrix_multiply(rotation_x(pi()/2))
     |> matrix_multiply(scaling(5,5,5))
     |> matrix_multiply(translation(10,5,7))
     |> IO.inspect()
   )
    assert matrix_equal?(result,point(15,0,7)) == true
 
    result =(
     point(1,0,1)
     |> matrix_multiply(identity())
     |> matrix_multiply(rotation_x(pi()/2))
     |> matrix_multiply(scaling(5,5,5))
     |> matrix_multiply(translation(10,5,7))
     |> IO.inspect()
   )
  end

  test "piped transforms API " do
   result =(
     point(1,0,1)
     |> (rotate_x(pi()/2))
     |> (scale(5,5,5))
     |> (translate(10,5,7))
     |> IO.inspect()
   )
    assert matrix_equal?(result,point(15,0,7)) == true
  end 
end 



