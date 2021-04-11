defmodule Ray do
  import Math
  import CoordOps
  import Matrix
  import Shading

 # @type ray_type() :: %{origin: tuple(), direction: tuple()}
  
  def ray(origin \\ point(0,0,0),direction \\ vector(0,0,0)) do
    %{origin: origin, direction: direction}
  end
  @doc """
  position(ray, scale_value) :: point
  moves a ray origin point and rturns the new point
  """  
 def position(r,scale_value) do
    scale_tuple(r.direction , scale_value)
    |> add_tuple(r.origin)
  end

  def transform(ray,transform_matrix) do
    rp =  matrix_multiply(transform_matrix,ray.origin)
    rv = matrix_multiply(transform_matrix,ray.direction)
    ray(rp,rv)
  end

  @doc """
  determine the shading color at point where a ray intersects nearest object
  - get all world intersection for the ray
  - get the hit (nearest intersect)
  - prepare computations
  - return color at hit point
  """
  def color_at(world,ray) do
    intersect_world(world,ray) 
    |> hit()
    |> process_hit(world,ray)
  end

  @doc """
  determine the color at the hit point. if there is no hit then return black
  if a hit is successful then return the result of shade_hit()
  """
  # when ray does not hit anytihing return black
  def process_hit(intersect,_world,_ray) when intersect == {:miss, 0}  do
    {0,0,0}
  end

  def process_hit(intersect,world,ray) do 
    prepare_computations(intersect,ray)
    |> shade_hit(world)
  end

  @doc """
  calculates the color of the point where the ray hits the object in the scene
  requires a comps map containing results from prepare_computations(intersection,ray)
  """ 
  def shade_hit(comps,world) do
    lighting(comps.object.material,
      Enum.at(world.lights,0),
      comps.point,
      comps.eyev,
      comps.normalv)
  end

  
  @doc """
   determines intersections between the ray and any world objects.    
   return a single list of intersections in ascending order of distance from ray origin (t)
  """
  def intersect_world(world,ray) do
    compute_intersects(world,ray)
    |> intersections()
  end

  @doc """
  get all **world** intersects for a **ray** 
  """
  def compute_intersects(world,ray) do
    Enum.map(world.objects,fn sphere -> intersect(sphere,ray) end )
  end

  @doc """
  sort intersections by t value
  """
  def sort_intersections(intersect_list) do
    Enum.sort_by(intersect_list,fn intersect -> intersect.t end)
  end

  @doc """
  determine if an intersect is inside an object
  """
  def inside?(normalv,eyev) do
      if dot(normalv,eyev) < 0 do
        {true, negate(normalv)}
      else  
        {false, normalv}
      end
  end

  @doc """
  Series of pre calculations for use when calculating color at intersection
  - object
  - t (distance from ray oriin to hit point)
  - point hit point on object
  - eyev
  - normalv
  - inside (true or false)

  """
  def prepare_computations(intersection,ray) do
    s = intersection.object
    t = intersection.t
    p = position(ray,t)
    eyev = negate(ray.direction)
    normalv = normal_at(s,p)
    {inside, normalv} = inside?(normalv,eyev)

    %{object: s, 
      t: t, 
      point: p, 
      eyev: eyev,
      normalv: normalv,
      inside: inside
    }
  end
  
  @doc """
  return the lowest  non negative intersection **t** value from a list of intersectsions  
  the supplied list is sorted in ascending order of **t**
  hit(intersections) :: intersection :: %{t: t, object: obj}
  """
  def hit(sorted_intersections) do
    Enum.find(sorted_intersections,{:miss, 0},fn intersection -> intersection.t >= 0 end)
  end

  @doc """
  hit test on an unsorted list of intersection maps. 

  Success returns the lowest non negative t value
  No hits returns {:miss, 0}
  """
  def hit_unsorted(intersections) do
    Enum.filter(intersections, fn(imap) -> imap.t >= 0 end)
    |> Enum.min_by(fn map -> map.t end,fn -> {:miss, 0} end)
  end
   
  @doc """
  intersections returns sorted list of intersection maps  in ascending order of t
  [%{object: obj, t: t}, .....]
  """
  def intersections(intersect_list) do
    List.flatten(intersect_list)
    |> sort_intersections()
  end

  @doc """
  creaes a map of the intersection t value and the object intersected
  intersection(t,obj) :: %{t: t, object: obj}
  """
  def intersection(t,obj) do
    %{t: t, object: obj}
  end 

 
   @doc """
   return a single intersect record from list by index 
   """
  def intersect_at(intersects,index) when length(intersects) > 0 do
    Enum.at(intersects,index)
  end

  @doc """
  intersect calculates intersections between ray and single object
  transforms the ray using the inverse of the object transform  
  calculates the discriminant to determine points of intersection  
  returns: any intersections found as a list.

  [%{t: t, object: obj}...] 
  """
  def intersect(obj,ray) do
   # mod so that ray is transformed by the sphere before calculating
   # calculate the intersection maps for this object 
   # compile into a list 
   t_list = 
   transform(ray,invert(obj.transform))      
   |> discriminant(obj.origin) 
   
   for t <- t_list, do: intersection(t,obj)  
  end

  def discriminant(ray,sphere_origin) do
    s_to_r = subtract_tuple(ray.origin, sphere_origin)
    a = dot(ray.direction,ray.direction)
    b = 2 * dot(ray.direction,s_to_r)
    c = dot(s_to_r,s_to_r) -1
    #
    # return the discriminant
    result = b*b - (4 * a * c)
    if result < 0 do
      []
    else
      [(-b - sqrt(result)) / (2 * a), (-b + sqrt(result)) / (2 * a)]
    end
  end

end

