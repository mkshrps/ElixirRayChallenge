defmodule World do
  import Sphere
  import Material
  import CoordOps
  import Transforms
  import Lights

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
    m = material(ambient: 1,color: color(0.8,1.0,0.6), diffuse: 0.7,specular: 0.2)
    m1 = material(ambient: 1)
    s1 = sphere(material: m)
#    IO.inspect(s1)
    s2 = sphere(transform: scaling(0.5,0.5,0.5),material: m1)
#    IO.inspect(s2)
    light = point_light(point(-10,10,-10),color(1,1,1))
    world(objects: [s1,s2],lights: [light])
  end

  def add_object_to_world(world,obj) do
    obj_list = world.objects
    struct(world,objects: [obj | obj_list])
  end

  def add_light_to_world(world,light) do
    light_list = [light| world.lights]
    struct(world,lights: light_list)
  end

  def get_world_object(object_list,index) do
    Enum.at(object_list,index)
  end
end
