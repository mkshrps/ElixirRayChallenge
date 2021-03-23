defmodule Ray do
  import Math
  import CoordOps
 # @type ray_type() :: %{origin: tuple(), direction: tuple()}
  
  def ray(origin \\ point(0,0,0),direction \\ vector(0,0,0)) do
    %{origin: origin, direction: direction}
  end
# @spec position(ray_type(),number()) :: tuple() 
  def position(r,scale_value) do
    scale_tuple(r.direction , scale_value)
    |> add_tuple(r.origin)
  end

  def sphere() do
    %{ id: gen_reference(), origin: point(0,0,0)}
  end
  
  def intersection(t,obj) do
    %{t: t, object: obj}
  end

  def intersections(intersection_list,new_intersection_list) do
    Enum.concat(intersection_list,new_intersection_list)
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

  def intersect(_sphere,ray) do
    sphere_origin = point(0,0,0)
    discriminant(sphere_origin,ray) 
  end

end

