defmodule Canvas do
#  import P3_file

  @doc """
  Set of canvas building functions. 
  builds a canvas map where the keys are the index 1..n %{ 1 => {1,1,1}, 2 => {1,1,1}...}
  returns screen_map %{canvas_map, width: row, height: col}
  """
  def build_canvas(width,height,color) do
    canvas = for key <- 0..width * height, into: %{}, do: {key,color}
    Map.put(%{ width: width, height: height}, :canvas, canvas) 
  end

  def copy_canvas(pixel_list) do
    IO.puts("copying canvas")
    for key <- 0..length(pixel_list)-1, into: %{}, do: {key,Enum.at(pixel_list,key)}
    IO.puts("done")
  end


  def build_canvas_map(row,col,init_color) do
    canvas =  build_canvas_map(%{},0,row * col,init_color)
    %{canvas: canvas , 
      width: row, 
      height: col, 
      pscale: 1, 
      orgx: 0, 
      orgy: 0,
      dxw: 1, # world pixel conversion
      dyw: 1  # x and y world units / pixel
      }
  end

  # convert world units to pixels  
  def world_to_pixel(world_width,world_height,%{width: width, height: height}= canvas_map) do
    canvas_map
    |> Map.put(:dxw,world_width/width)
    |> Map.put(:dyw,world_height/height)
  end 

  def dx_w(world_width,canvas_width) do
    world_width/canvas_width
  end

  def dy_w(world_height,canvas_height) do
    world_height/canvas_height
  end

  def build_canvas_map(map,start,term,_init_color) when start == term do
    map
  end

  def build_canvas_map(map,start,term,init_color) do
    #IO.puts(start)
    Map.put(map,start,init_color)
    #|> canvas_map(start+1,term,{start+1,1,1})
    |> build_canvas_map(start+1,term,init_color)
  end
 
  def loc(map,x,y) do
    if (y >= 0 and y< map.height) and (x >=0 and x < map.width) do 
      {:ok, ((y * map.width) + x)}
    else
      {:error , "coord out of limits"}
    end
  end
 
 @doc """
  pixel write and read functions
  get_pixel(canvas_map,x,y) -> canvas_map
  """
  
  def set_pixel(canvas_map,x,y,color) do
    case loc(canvas_map,x,y) do
      {:ok, coord} ->
        IO.inspect({x,y,coord,color})
        put_in(canvas_map,[:canvas,coord],color)  
      {:error, msg } ->
        IO.puts("#{msg} #{x},#{y}")
        canvas_map        
    end
  end
  
  def get_pixel(canvas_map,x,y) do
    case loc(canvas_map,x,y) do
      {:ok,coord} ->  
      canvas_map.canvas[coord] 
      {:error, msg } ->
      IO.puts("#{msg} #{x},#{y}")
      msg
    end
  end
  @doc """
  functions for plotting to canvas adjust x,y coordinates to take account of 
  canvas (0.0) origin being at top
  """
  def plot_pixel(map,x,y,color) do
    px = round(x)
    py = map.height - round(y)
    set_pixel(map,px,py,color)
  end

    def plot(map,count,line,color) when count > 0  do
    map = plot_pixel(map,map.width - count,line,color)
    plot(map,count-1,line,color)
    
    end
 
  def plot(map,0,_,_) do
    map
  end

  def decode_plot(map,px,py) do
    x = px 
    y = map.height - py
    {x,y,get_pixel(map,x,y)}
  end

end

