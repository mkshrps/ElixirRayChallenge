defmodule Test  do
  _people = [
    %{name: "Grumpy", height:  1.24},
    %{name: "Billy", height:  1.34},
    %{name: "Tommy", height:  1.44},
    %{name: "Sammy", height:  1.54}
  ]
  def recurse([]) do
    0
  end

  def recurse([1|_t]) do
    IO.puts("found 1 ")
    :error
  end

  def recurse([h|t]) do
    [h+1|recurse(t)]
  end

  def f_coords([x: x1,y: y1],[x: x2,y: y2],[f: f1,f: f2]) do
    [x: f1.(x1,x2), y: f2.(y1,y2)]
  end
  
  def op(coord1,coord2,funcs) do
    for i <- coord1, j <- coord2, f<- funcs, do: f.(i,j)
  end

  def is_point([{:x,_x},{:y,_y},{:z,_z},{:w,w}]) when w === 1.0, do: true 
  def is_point([{:x,_x},{:y,_y},{:z,_z},{:w,w}]) when w === 0.0, do: false 

end


