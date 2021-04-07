defmodule Clock do
  import Math
  import CoordOps
  import Canvas
  import Transforms
  import Ray
  import P3_file
  import Sphere
  import Matrix
  import Transforms
  import Material
  import Shading
  import Lights

  def clock(points,scale) do
    canvas_map = build_canvas_map(100,100,{0,0,0})
    org_x = canvas_map.width / 2
    org_y = canvas_map.height /2
    pscale = scale
    canvas_map = Map.put(canvas_map,:orgx,org_x)
    canvas_map = Map.put(canvas_map,:orgy,org_y)
    canvas_map = Map.put(canvas_map,:pscale,pscale)

    #vector(sqrt(3)/3,sqrt(3)/3,sqrt(3)/3) Execute transforms and plot file
    p = point(0,0,1)
    # build list of points to plot
    Enum.scan(0..points-1,p,fn _x,p ->  rotate_y(p,pi()/(points/2))  end)
    # isert them into canvas
    |> Enum.reduce(canvas_map,fn p,cm -> plot_value(p,cm) end)
    # output to the file
    |> P3_file.generate_ppm_file("clock2.ppm")
  end

  def draw_sphere_r(r,c) do
    #canvas_map = build_canvas_map(100,100,{0,0,0})
    # place the world origin on the canvas
    #canvas_map = Map.put(canvas_map,:orgx,org_x)
    #canvas_map = Map.put(canvas_map,:orgy,org_y)
  #  canvas_map = Map.put(canvas_map,:pscale,pscale)
    wall_size = 8
    height = r 
    width  = c 
    file = "sphere3.ppm"
    start_ppm_file(height,width,file)

    dx_w = dx_w(wall_size,width)
    dy_w = dx_w
    half = wall_size/2

    # create a sphere origin at 0,0,0
    s = sphere()
    m = material()
    m = update_material(m,:color,{1,0.2,1})
    s = update_sphere(s,:material,m)
    ray_origin = point(0,0,-10) 
    tr = matrix_multiply(rotation_z(pi()/4),scaling(1.75,1.0,1.0))
    s = set_transform(s,tr) 
    IO.inspect(s)
    light_pos = point(-10,10,-10)
    light_color = color(1,1,1)
    light = point_light(light_pos,light_color)

    for y <- 0..height-1 do 
      for x <- 0..width-1 do
        wx = -half + (x * dx_w) # set target x and y in world coords where origin is half width

        wy = (half - (y * dy_w))
        # fire a ray at the wall
        v = subtract_tuple(point(wx,wy,5),ray_origin)
        ray = ray(point(0,0,-10),normalize_vector(v))
       
        intersect(s,ray) |> hit() 
        # get the color value at the hitpoint
        |> check_hit_3d(ray,light)
      end
      |> line_to_string()
      |> add_to_file(file)
 
    end
 end
  
  def check_hit_3d({:miss, _},_,_) do
    {0,0,0}
  end

  def check_hit_3d(rayhit,ray,light) do
    hitpoint = position(ray,rayhit.t)
    normal = normal_at(rayhit.object,hitpoint)
    eye = negate(ray.direction)
    lighting(rayhit.object.material,light,hitpoint,eye,normal)     
  end

  def draw_sphere(r,c) do
    #canvas_map = build_canvas_map(100,100,{0,0,0})
    # place the world origin on the canvas
    #canvas_map = Map.put(canvas_map,:orgx,org_x)
    #canvas_map = Map.put(canvas_map,:orgy,org_y)
  #  canvas_map = Map.put(canvas_map,:pscale,pscale)
    wall_size = 8
    height = r 
    width  = c 
    file = "sphere1.ppm"
    start_ppm_file(height,width,file)

    dx_w = dx_w(wall_size,width)
    dy_w = dx_w
    half = wall_size/2

    # create a sphere origin at 0,0,0
    s = sphere()
    ray_origin = point(0,0,-10) 
    for y <- 0..height-1 do 
      for x <- 0..width-1 do
        wx = -half + (x * dx_w) # set target x and y in world coords where origin is half width

        wy = -half + (y * dy_w)
        # fire a ray at the wall
        v = subtract_tuple(point(wx,wy,5),ray_origin)
        ray = ray(point(0,0,-10),normalize_vector(v))
        intersect(s,ray)
        |> hit() 
        |> check_hit()
      end
      |> line_to_string()
      |> add_to_file(file)
 
    end
 end
  
  def create_canvas(pixel_map,width,height) do
    Map.put(%{ width: width, height: height}, :canvas, pixel_map) 
  end
  def check_hit({:miss, _}) do
   #   IO.puts("black")
    {0,0,0}
  end

  def check_hit(_) do
   #  IO.puts("red")
    {1,0,0}
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

