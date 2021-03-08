
defmodule Canvas do
  #import CoordOps

  def build_canvas(width,height,init_color) do
    canvas = new_canvas_contig(width,height,init_color,0,{}) 
    %{canvas: canvas,width: width, height: height}
  end

  def new_canvas_contig(width,height,color,count,canvas) when count < (width * height) do
    new_canvas_contig(width,height,color,count+1,Tuple.append(canvas,color))  
  end

  def new_canvas_contig(_,_,_,_,canvas)  do
    canvas
  end
  
  def set_pixel_limit(canvas,width,height,row,col,color) when row <= height and col <= width do 
    #canvas = canvas_map[:canvas]
    #canvas = put_elem(canvas_map[:canvas],(canvas_map[:width] * (row-1))+(col-1),color) 
    canvas = put_elem(canvas, (width * (row-1))+col-1,color) 
    IO.inspect(canvas)
    #%{canvas_map | canvas: canvas}
  end
  def set_pixel_limit(_,_,_,_,_,_) do
    {:error , "x , y outside limits"}
  end

  def set_pixel(canvas_map,row,col,color) do
    canvas = put_elem(canvas_map[:canvas], (canvas_map[:width] * row)+col,color) 
    %{canvas_map | canvas: canvas}
#    IO.inspect(canvas)
  end

  def get_pixel(canvas_map,row,col) do
     elem(canvas_map[:canvas],canvas_map[:width] * (row) + (col))
  end

  # map tuple (pixel) values from 0..1 to 0..255
  # return results in a 3 element list
  def pix_to_255(pixel) do
    l = Tuple.to_list(pixel)
    Enum.map(l,fn(x) -> 
      cond do
      x < 0 -> 0
      x > 1 -> 255  
      x>= 0 and x<=1 -> round(x * 255) 
      end 
    end)
  end

  # add new mapped pixel value to a list l
  def add_pixel_to_list(pixel,list) do
    pix_to_255(pixel)
    |> Enum.concat(list)
  end

  def canvas_to_list(canvas_map) do
    canvas = canvas_map[:canvas]
    #for p <- canvas, do: add_pixel_to_list(p,list)
    size = tuple_size(canvas)
    make_list(canvas,size,0,[])
  end

  def make_list(canvas,size,count,list) when count < size do
    pixel = elem(canvas,count)
    make_list(canvas,size,count+1,add_pixel_to_list(pixel,list))
  end

  def make_list(_,_,_,list) do
    list
  end
  # canvas width = width of canvas in pixels (1 pixel = 8 chars)
  # char count = counter for a line in characters max line width = 70
  # pixel count = curent number of pixels on curreent line
  # 
 """
  def format_string(canvas_width,char_count,pixel_count,dest_str) do
    
  if (char_count > 62) do 
      dest_str = add_newline(dest_str)
      char_count = char_count + 2
      
    end
    if pixel_count > canvas_width do 
      dest_str = add_newline(dest_str)
      char_count = char_count + 2
      |> add_pixel_to_line(str_count)
    end
      dstr <> String.at(source_str,lcount)
      str <> pix_to_255(pixel)
  end
"""

  def canvas_to_string_direct(canvas_map) do
    canvas = canvas_map[:canvas]
    size = tuple_size(canvas)
 #   make_string(canvas,canvas_map[:width],size,0,"")
  end

  def canvas_to_string(canvas_map) do
    canvas_to_list(canvas_map)
    |> Enum.reduce(fn item,str ->"#{str} " <> "#{item}" end)
  end

  # add PPM header 
  # P3 format
  # width height of canvas
  # bit depth (255)
  # canvas string
  #
  def add_header(str,canvas_map) do
    "P3 \n#{canvas_map[:width]} #{canvas_map[:height]}\n255\n" <> str  
  end

  def format_for_ppm(ppm_string) do
    ppm_string
  end

  def write_to_ppm_file(ppm_string,fname) do
    ppm_string
  end

  def ppm_file(canvas_map,fname) do
    canvas_to_string(canvas_map)
    |> add_header(canvas_map)
    |> format_for_ppm()
    |> write_to_ppm_file(fname)
  end
end

