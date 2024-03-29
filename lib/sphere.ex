defmodule Sphere do
  import CoordOps
  import Transforms

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

  def test() do
  end

  defstruct [
    :id ,
    material: %Material{},
    origin: point(0,0,0),
    transform: identity()
  ]
  
  def sphere() do
    %Sphere{id: gen_reference()}
  end
  # opts are keyword list of sphere properties
  # material = Material map
  # origin
  # transform
  #
  def sphere(opts) do
    struct(sphere(),opts)
  end

  def update_sphere(s,opts) do
    struct(s,opts)
  end

  def update_sphere(s,key,val) do
    Map.put(s,key,val)
  end

  def update_sphere_material(s, material_opts) do
    material_struc = s.material  
    material_struc = struct(material_struc,material_opts)
    struct(s,material: material_struc)
  end

  @doc """
   def sphere(origin \\ point(0,0,0),transform \\ identity(),material \\ material()) do
    %{ id: gen_reference(), 
    

      origin: origin,
       transform: transform,
       material: material
    }
  end

 
  """
  def set_transform(object,transform) do
    Map.put(object,:transform,transform)
  end
  
  def set_obj_material(object,material) do
    Map.put(object,:material,material)
  end

end
