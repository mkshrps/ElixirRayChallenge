defmodule P3_file do
  import Canvas

  @doc """
  PPM mode_3 file generation functions
  """
  def generate_ppm_file(canvas_map,filename) do
    r = canvas_map.width
    c = canvas_map.height
    File.write(filename,"P3\n#{r} #{c}\n255\n")    
    canvas_map.canvas
    |> canvas_to_ppm(0,r,c,filename)
  end

  @doc """
  open a ppm file and write the header block
  P3
  rows columns
  255
  """
  def start_ppm_file(rows,cols,filename) do
    File.write(filename,"P3\n#{rows} #{cols}\n255\n")    
  end

  @doc """
  canvas_to_ppm()
  Takes a canvas  map

  Each row as a list of pixel tuples {r,g,b} each pixel value is a float between 0 and 1
  Each row is processed and output to a file defined by the filename 
  The file is assumed to contain the ppm header
 
  def canvas_to_ppm(_canvas,_,_,0,_) do
    {:ok}   
  end
  """

  def canvas_to_ppm(canvas,start,width,rowcount,fileptr) do
    if rowcount > 0 do
    get_row_from_map(canvas,start,width)
    |> line_to_string()
    |> add_to_file(fileptr)
    # process nexr row 
    canvas_to_ppm(canvas,start + width,width,rowcount-1,fileptr)
    else
      {:ok}
    end
  end

  def get_row_from_map(map,start,row_size) do
    for n <- start..(start + (row_size-1)), do: map[n]  
  end

  def add_to_file(str,filename) do 
    File.write(filename,str,[:append])
  end
  # row_to_string(pixels) 
  # takes a list of color - tuples (values 0-1) representing a row on the cnvas
  # outputs a converted list of values mapped 0 - 255
  #
  def row_to_string(pixels) do
    List.foldr(pixels, [], fn({r, g, b}, a) -> [r,g,b | a] end) 
    |> Enum.map(fn 
       x when x <= 0 -> 0
       x when x >= 1 -> 255  
       x ->  trunc(x*255) 
      end)
    |> to_str() 
  end
  # line_to_string()
  # same as row_to_string() using reduce and reverse
  def line_to_string(pixels) do
    # convert a canvas row (list of pixel tuples) to a flat list of values
    # mapped between 0 and 255
    Enum.reduce(pixels,[],fn {x,y,z}, acc -> [z,y,x|acc] end )
    |> Enum.map(fn 
       x when x <= 0 -> 0
       x when x >= 1 -> 255  
       x ->  trunc(x*255) 
      end)
    |> Enum.reverse()
    # output the flat list to a ppm string clipping lines at 70 chars max 
    |> to_str()
  end

  def to_str(list) do
    maxcount = 70
    to_str("",list,maxcount,0)
  end

  def to_str(str,[],_,_) do
    String.trim(str) <> "\n"
  end

  def to_str(str,list,maxcount,lcount) when lcount > maxcount do
    str = String.trim(str) <> "\n"
    to_str(str,list,maxcount,0)
  end

  # default operation add new value to the string 
  # this is the only place where we add a value to the string
  def to_str(str,[h|list],maxcount,lcount) do
    if (numlen(h) + lcount) > maxcount do
      # if next value won't fit on this line force a new line
      # lcount = maxcount + 1  
      to_str(str,[h|list],maxcount,maxcount+1)
      
    else
   #   lcount = lcount + String.length("#{h} ")
      str <> "#{h} "
      |> to_str(list,maxcount,lcount+ numlen(h) + space())
    end
  end

  def space(), do: 1 

  def numlen(n) do
    String.length("#{n}")
  end

  def test_plot(width,height)  do
    map = build_canvas_map(width,height,{0,0,0})
    map = plot(map,width,25,{1,1,1}) 
    map = plot(map,width,26,{1,1,1}) 
    map = plot(map,width,27,{1,1,1}) 
    generate_ppm_file(map,"test1.ppm")
    map
  end

end
