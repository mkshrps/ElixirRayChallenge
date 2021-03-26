defmodule Ray do
  import Math
  import CoordOps
  import Matrix
  import Transforms

 # @type ray_type() :: %{origin: tuple(), direction: tuple()}
  
  def ray(origin \\ point(0,0,0),direction \\ vector(0,0,0)) do
    %{origin: origin, direction: direction}
  end
# @spec position(ray_type(),number()) :: tuple() 
  def position(r,scale_value) do
    scale_tuple(r.direction , scale_value)
    |> add_tuple(r.origin)
  end

  def transform(ray,transform_matrix) do
    rp =  matrix_multiply(transform_matrix,ray.origin)
    rv = matrix_multiply(transform_matrix,ray.direction)
    ray(rp,rv)
  end
  

  def sphere(origin \\ point(0,0,0),transform \\ identity()) do
    %{ id: gen_reference(), origin: origin,transform: transform}
  end

  def set_transform(object,transform) do
    Map.put(object,:transform,transform)
  end

   def intersect(obj,ray) do
    obj_origin = obj.origin
     # mod so that ray is transformed by the sphere before calculating
    ray = transform(ray,invert(obj.transform))      

    # calculate the intersection maps for this object 
    # compile into a list 
    t_list = discriminant(obj_origin,ray) 
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


  def hit(list_of_intersects) do
    result = 
    Enum.filter(list_of_intersects, fn(imap) -> imap.t >= 0 end)
         |> Enum.min_by(fn map -> map.t end,fn -> {:miss, 0} end)
    
    result
  end

  # generate a uniq ID value for an object   
  def gen_reference() do
    min = String.to_integer("100000", 36)
    max = String.to_integer("ZZZZZZ", 36)

    max
    |> Kernel.-(min)
    |> :rand.uniform()
    |> Kernel.+(min)
    |> Integer.to_string(36)
  end

  def discriminant(sphere_origin,ray) do
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

