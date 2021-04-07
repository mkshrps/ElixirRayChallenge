defmodule World do
  import Sphere
  import Material
  import CoordOps
  import Transforms
  import Ray
  import Shading 

  defstruct [
    objects: [],
    lights: []
  ]
  # create a world struct with default values
  def world() do
   %World{}
  end
  # initialise the properties from the options list
  def world(opts) do
  
    struct(world(),opts)
  end

  # this is used for tests 
  def default_world() do
    m = material(color: color(0.8,1.0,0.6), diffuse: 0.7,specular: 0.2)
    s1 = sphere(material: m)
    IO.inspect(s1)
    s2 = sphere(transform: scaling(0.5,0.5,0.5))
    IO.inspect(s2)
    world(objects: [s1,s2])
  end

  def add_object_to_world(world,obj) do
    obj_list = struct(world,:objects)
    struct(world,objects: [obj | obj_list])
  end

  def intersect_world(world,ray) do
    # get a list of object intersections
    # each object returns a list of two intersections
    # so flatten to a single list of intersections
    # and return a list of intersects in ascending order 
    # of t
    Enum.map(world.objects,fn sphere -> intersect(sphere,ray) end )
    |> List.flatten()
    |> sort_intersections()
  end

  def sort_intersections(intersect_list) do
    Enum.sort_by(intersect_list,fn intersect -> intersect.t end)
  end

  def prepare_computations(intersection,ray) do
    s = intersection.object
    t = intersection.t
    p = position(ray,t)
    %{object: s, 
      t: t, 
      point: p, 
      eyev: negate(ray.direction),
      normalv: normal_at(s,p)
    }
  end

end
