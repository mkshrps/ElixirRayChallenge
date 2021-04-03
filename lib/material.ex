defmodule Material do
  
  defstruct [
    color: {1,1,1},
    ambient: 0.1,
    diffuse: 0.9,
    specular: 0.9,
    shininess: 200.0
  ]

  def material() do
    %Material{}
  end

  def material(color,ambient,diffuse,specular,shininess) do
    %Material{
      color: color,
      ambient: ambient,
      diffuse: diffuse,
      specular: specular,
      shininess: shininess}

  end

  def update_material(mat,key,val) do
    Map.put(mat,key,val)
  end


  
end
