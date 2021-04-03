defmodule Ray do
  import Math
  import CoordOps
  import Matrix

 # @type ray_type() :: %{origin: tuple(), direction: tuple()}
  
  def ray(origin \\ point(0,0,0),direction \\ vector(0,0,0)) do
    %{origin: origin, direction: direction}
  end
  @doc """
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

   def intersect(obj,ray) do
     # mod so that ray is transformed by the sphere before calculating
     # calculate the intersection maps for this object 
     # compile into a list 
     t_list = 
     transform(ray,invert(obj.transform))      
     |> discriminant(obj.origin) 
     
     for t <- t_list, do: intersection(t,obj)  

     # could incorporate count here as well with deeper map
     # %{count: length(l),ray_obj_intersections: result_of_for_loop}
   end

  # easy function to get intersection record at index (0 or 1)
  def intersect_at(intersects,index) when length(intersects) > 0 do
    Enum.at(intersects,index)
  end

  def intersection(t,obj) do
    %{t: t, object: obj}
  end 

  def intersections(intersection_list,new_intersection_list) do
    Enum.concat(intersection_list,new_intersection_list)
  end

  def intersections(intersection_list) do
    intersection_list
  end
  
  @doc """
    hit(list of intersects) :: intersect :: %{t: t, object: obj}
    """
  def hit(list_of_intersects) do
    result = 
    Enum.filter(list_of_intersects, fn(imap) -> imap.t >= 0 end)
    |> Enum.min_by(fn map -> map.t end,fn -> {:miss, 0} end)
    result
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

