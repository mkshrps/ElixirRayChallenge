defmodule Matrixtest do
  use ExUnit.Case
  import Matrix
  import Testmatrix

  test "create matrices" do
    assert  length(create_matrix(4)) == 4
    assert  length(create_matrix(3)) == 3
    assert  length(create_matrix(2)) == 2
    assert  length(List.first(create_matrix(4))) == 4
    assert  length(List.first(create_matrix(3))) == 3
    assert  length(List.first(create_matrix(2))) == 2
  end


  test "multiply etc" do
    assert matrix_multiply(multiply_list1(),multiply_list2()) == multiply_result() 
       # test with single column matrix (list) 
    assert matrix_multiply(tuple_matrix(),tuple_list()) == tuple_result()
    # test with a 4 element tuple (point or vector)
    assert matrix_multiply(tuple_matrix(),test_point()) == point_result()
    assert is_invertible(invertible()) == true
    assert is_invertible(noninvertible()) == false
    assert invert(inverse()) == inverse_result()

    assert invert(inverse2()) == inverse_result2()
    assert invert(inverse3()) == inverse_result3()

    mc = matrix_multiply(inverse_mul(),inverse_mul2())
    mr =  matrix_multiply(mc, invert(inverse_mul2())) 
    assert matrix_equal?(mr,inverse_mul()) == true 
  end
end

