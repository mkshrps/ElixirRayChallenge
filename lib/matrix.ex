defmodule Matrix  do

  def create_matrix(size) do
    for _n <- 0..size-1, do: list_n(size)
  end

  def list_n(size) do
    for _n <- 0..size - 1, do: 0 
  end

  def matrix_fetch(matrix,row,col) do
    List.flatten(matrix)
    |>  Enum.at(row * length(matrix) + (col))
  end

  def matrix_update(matrix,row,col,new_value) do
    row_to_update = Enum.at(matrix,row)
    update = List.update_at(row_to_update,col,fn _e -> new_value end)
    List.update_at(matrix,row,fn _e -> update end)    
  end

  # compare values in two matrices and return true if approxiamtely equal
  # uses Enum.any? which will exit on first failure with true 
  # but we need to return false in that case
  
  # m2 can be a tuple (point or vector)
  def matrix_equal?(m1,m2={_x,_y,_z,_w}) do
    Tuple.to_list(m2)
    |> matrix_equal?(m1)
  end

  def matrix_equal?(m1,m2) do
    l1 = List.flatten(m1)
    l2 = List.flatten(m2)
    result = (Enum.zip(l1,l2)
   # |> IO.inspect()
    |> Enum.any?(fn {x,y} -> abs(x-y) >  0.11 end )
    )
    !result
  end

  # determinant of 2x2 matrix [[a,b][c,d]]
  # matrix = [a,b],[c,d]
  #swap [c,d]
  #[a,b],[d,c]
  #Zip the lists
  #[{a,d},{b,c}]
  # multiply the tuple values and map to new list
  # [a*d,b*c]
  # subtract ad - bc (careful to do this from right
  #
  def is_invertible(matrix) do
    determinant(matrix) != 0
  end
  #
  # alias for invert
  def inverse(matrix) do
    invert(matrix)
  end

  def invert(matrix) do
    size = length(matrix) -1
    det = determinant(matrix)
    m = for row <- 0..size, do:
      for col <- 0..size, do: Float.round(cofactor(matrix,row,col) / det ,5)
    transpose(m)
  end

  def invert_r(matrix) do
    size = length(matrix) -1
    det = determinant(matrix)
    m = for row <- 0..size, do:
      for col <- 0..size, do: Float.round(cofactor(matrix,row,col) / det)
    transpose(m)
  end


  def determinant([[a,b],[c,d]]) do
    a*d - b*c
  end

  # note: cofactor calls determinnnant recursively
  def determinant(matrix) do
    row = List.first(matrix)
    (for n <- 0..length(row)-1,  do: cofactor(matrix,0,n)) 
    |> list_multiply(row)
    |> Enum.reduce(fn x,acc -> x + acc end)
  end
  
  def minor(matrix,row,col) do
    submatrix(matrix,row,col)
    |> determinant()
  end

  # same as minor but alters sign if required
  # if row + col is odd swap sign
  def cofactor(matrix,row,col)  do
    m = minor(matrix,row,col)
    if rem(row+col,2) == 1 do 
      -m
    else
      m
    end
  end

  def submatrix(matrix,row,col) do
    remove_item(matrix,row)
    |> remove_col(col)
  end

  def remove_col(rowlist,col_index) do
    for n <- rowlist, do: remove_item(n,col_index)
  end

  def remove_item(matrix,item) do
    List.delete_at(matrix,item)
  end


 # list of columns([[r0.0,r0.1,r0.2,r0.3],][r1.0,r1.1,r1.2,r1.3],...) :: [r0.0,r1.0]
  # col is zero based
  # get matrix size by checking length of first nested list
  # [h|[]] = List.at(l,col-1)
  # flatten nested list of rows into 1 list
  # dop the first col-1 values so we are picking the first column value from front of the list
  # grap the values for the column

  # convert rows to columns and vice versa
  def transpose(matrix) do
    size = length(matrix)
    for n <- 0..size-1, do: get_column(matrix,n)
  end

  def get_column(matrix,col) do
    #row_size = length(List.first(matrix))
    size = length(matrix)
    List.flatten(matrix)
    |> Enum.drop(col)
    |> Enum.chunk_every(1,size)
    |> Enum.concat()
  end

  def get_row(matrix,row) do
    matrix
    |> Enum.drop(row)
    |> List.first()
  end
  # multiply each value in list by corrresponding value in list1
  def list_multiply(row_list,col_list) do
    Enum.zip(row_list,col_list)
    |> Enum.map(fn({x,y}) -> x * y end)
  end
  
  def row_by_col_mul(matrix1,matrix2,row_index,col_index) do
    row = get_row(matrix1,row_index)
    col = get_column(matrix2,col_index)
    list_multiply(row,col)
    |> Enum.reduce(0,fn(x,acc) -> x + acc end)
  end

  def row_by_tuple_mul(matrix1,col,row_index) do
    row = get_row(matrix1,row_index)
    list_multiply(row,col)
    |> Enum.reduce(0,fn(x,acc) -> x + acc end)
  end

  # perform a matrix multiplication on m1,m2 where m1 provides rows and m2 provides cols
  # works for multi column and single column (t2) matrices and point/vector tuples
  #
  # point or vector need t be converted fron tuple to list
  # and convert back to tuple 
  def matrix_multiply(m,t = {_x,_y,_z,_w}) do
    matrix_multiply(m,Tuple.to_list(t))
    |> List.to_tuple()
  end
 
  # point or vector need t be converted fron tuple to list
  # and convert back to tuple 
  def matrix_multiply(t = {_x,_y,_z,_w},m) do
    matrix_multiply(m,Tuple.to_list(t))
    |> List.to_tuple()
  end
 
  # multi column where each columnn is a nested list
  def matrix_multiply(m1,[h|_t] =  m2) when is_list(h)  do
    size = length(List.first(m1))
    l = for row <- 0..size-1, col <- 0..size-1,  do: row_by_col_mul(m1,m2,row,col)
    Enum.chunk_every(l,4)
  end


  # single column list (t) multiplication
  def matrix_multiply(m1,t) do
    size = length(t)
    for row <- 0..size-1,  do: row_by_tuple_mul(m1,t,row)
  end

   
  def matrix_tuple_multiply(m1,t) do
    size = length(t)
    for row <- 0..size-1,  do: row_by_tuple_mul(m1,t,row)
  end
end


