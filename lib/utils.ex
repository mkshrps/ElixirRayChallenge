
defmodule Utils  do

  @moduledoc """
  Useful utility functions
  """

  @doc """
  trim rounds various types and structures to given precision.
  - List
  - color {r,g,b}
  - point or vector {x,y,z,w}
  
  """
  def trim({r,g,b}, precision) do
    {
      Float.round(r,precision),
      Float.round(g,precision),
      Float.round(b,precision)
    }
  end

  def trim({x,y,z,w}, precision) do
    {
      Float.round(x,precision),
      Float.round(y,precision),
      Float.round(z,precision),
      Float.round(w,precision)
    }
  end

  def trim(list,precision) when  is_list(list) do
    Enum.map(list,fn el -> Float.round(el,precision) end)
  end
   @doc """
  round a matrix (list of lists)  of any size to precision p
  
  Example:
  iex(32)> m
  [
    [-0.50709, 0.50709, 0.67612, -2.36643],
    [0.76772, 0.60609, 0.12122, -2.82843],
    [-0.35857, 0.59761, -0.71714, 0.0],
    [0.0, 0.0, 0.0, 1.0]
  ]

  iex(31)> trim_matrix(m,2)
  [
      [-0.51, 0.51, 0.68, -2.37],
    [0.77, 0.61, 0.12, -2.83],
    [-0.36, 0.6, -0.72, 0.0],
    [0.0, 0.0, 0.0, 1.0]
  ]
  """
  def trim_matrix(m,p) do
    Enum.map(m, &(&1)  |> Enum.map(fn i -> trim_value(i,p) end  ))
  end 

  def trim_value(i,p) when is_float(i) do
    Float.round(i,p)
  end

  def trim_value(i,_p) do
    i
  end
 
end
