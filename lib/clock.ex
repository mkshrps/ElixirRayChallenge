defmodule Clock do
  import Math
  import CoordOps
  import Canvas
  import Transforms
  
  def clock(points,scale) do
    canvas_map = build_canvas_map(100,100,{0,0,0})
    org_x = canvas_map.width / 2
    org_y = canvas_map.height /2
    pscale = scale
    canvas_map = Map.put(canvas_map,:orgx,org_x)
    canvas_map = Map.put(canvas_map,:orgy,org_y)
    canvas_map = Map.put(canvas_map,:pscale,pscale)
    #
    # Execute transforms and plot file
    p = point(0,0,1)
    # build list of points to plot
    Enum.scan(0..points-1,p,fn _x,p ->  rotate_y(p,pi()/(points/2))  end)
    # isert them into canvas
    |> Enum.reduce(canvas_map,fn p,cm -> plot_value(p,cm) end)
    # output to the file
    |> P3_file.generate_ppm_file("clock2.ppm")
  end
 
  def create_plots(_p,acc,0) do
    acc
  end

  def create_plots(p,acc,count) do
   p =  rotate_y(p, pi()/6)
   create_plots(p,[p|acc],count-1)
  end
  
  def plot_list([],canvas_map) do
    canvas_map
  end

  def plot_list([h|lst],canvas_map) do
    canvas_map = plot_value(h,canvas_map)
    plot_list(lst,canvas_map)  
  end

  def plot_value(pxyz , canvas_map) do
    {x,_y,z,_w} = pxyz
    point_scale = canvas_map.pscale
    xscale = point_scale * canvas_map.width
    yscale = point_scale * canvas_map.height
    px = (xscale * x) + canvas_map.orgx
    py = (yscale * z) + canvas_map.orgy
    IO.puts("px: #{round(px)} py: #{round(py)} ")
    plot_pixel(canvas_map,px,py,{1,1,1})
  end
end

