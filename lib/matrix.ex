
defmodule Matrix  do
  def matrix(size) do
    for _n <- 0..size-1, do: list_n(size)
  end

  def list_n(size) do
    for _n <- 0..size - 1, do: 0 
  end

  # list of columns([[r0.0,r0.1,r0.2,r0.3F],][r1.0,r1.1,r1.2,r1.3],col) :: [r0.0,r1.0]
  # col is zero based
  # get matrix size by checking length of first nested list
  # [h|[]] = List.at(l,col-1)
  # flatten nested list of rows into 1 list
  # dop the first col-1 values so we are picking the first column value from front of the list
  # grap the values for the column

  def get_column(matrix,col) do
    size = length(List.first(matrix))
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


  # perform a 4x4 matrix multiplication on m1,m2 where m1 provides rows and m2 provides cols
  #
  def matrix_multiply(m1,m2) do
    size = length(List.first(m1))
    l = for row <- 0..size-1, col <- 0..size-1,  do: row_by_col_mul(m1,m2,row,col)
    Enum.chunk_every(l,4)
  end

  def matrix_tuple_multiply(m1,t) do
    size = length(t)
    for row <- 0..size-1,  do: row_by_tuple_mul(m1,t,row)
  end

  def identity() do
    [[1,0,0,0],[0,1,0,0],[0,0,1,0],[0,0,0,1]]
  end

  def tuple_list() do
    [1,2,3,1]
  end

  def tuple_matrix() do
    [[1,2,3,4],[2,4,4,2],[8,6,4,1],[0,0,0,1]]
  end

  def deflist1() do
    [[1,2,3,4],[5,6,7,8,],[9,8,7,6],[5,4,3,2]]
  end

  def deflist2() do
    [[-2,1,2,3],[3,2,1,-1],[4,3,6,5],[1,2,7,8]]
  end

  def deflist3() do
    [[1,2,3,4],[2,3,4,5],[3,4,5,6],[4,5,6,7]]
  end

  def deflist4() do
    [[0,1,2,4],[1,2,4,8],[2,4,8,16],[4,8,16,32]]
  end

end


