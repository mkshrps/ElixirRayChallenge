defmodule Shading do
  import Matrix
  import CoordOps
  import Math

  @doc """
  def lighting(material,light,point,eyev,normalv) do
  material
  light - ::light_t
  position - point defines origin of object being lit in world space
  eyev - vector to eye
  normalv - vecto to normal from surface at point of intersection
  """
  def lighting(material,light,obj_point,eyev,normalv) do
    # color value
    effective_color = multiply_tuple(material.color,light.intensity)
    lightv = subtract_tuple(light.position, obj_point) |> normalize()
    reflect_dot_eye = reflect(negate(lightv), normalv) |> dot(eyev)

    light_dot_normal = dot(lightv,normalv)

    ambient = calc_ambient(effective_color,material.ambient)
   
    diffuse = calc_diffuse(effective_color,material.diffuse,light_dot_normal)
  
    specular = calc_specular(reflect_dot_eye,material,light,light_dot_normal)
             
    # end up with three color tuples add them to get the final value
    add_light([ambient, diffuse, specular])
  end

  def add_light(list) do
    Enum.reduce(list,fn v,acc -> add_tuple(v,acc)  end)
  end

  def calc_specular(reflect_dot_eye,_,_,light_dot_normal) when light_dot_normal <= 0 or reflect_dot_eye <= 0 do
    {0,0,0}
  end

  # 
  def calc_specular(reflect_dot_eye,material,light,_light_dot_normal) do
    factor = pow(reflect_dot_eye,material.shininess) * material.specular
    scale_color(light.intensity,factor) 
  end


  def calc_diffuse(_,_,light_dot_normal) when light_dot_normal < 0 do
    {0,0,0}
  end

  def calc_diffuse(effective_color,diffuse_v,light_dot_normal) do
    scale_color(effective_color,diffuse_v)
    |> scale_color(light_dot_normal)
  end

  # cale color by scalar value
  def calc_ambient(color,ambientv) do
    scale_color(color,ambientv)
  end

  def point_light( position \\ point(0,0,0), intensity \\ color(1,1,1) ) do
    %{position: position, intensity: intensity}
  end

  def scale_color({r,g,b},scale) do
    {r * scale, g * scale, b * scale}
  end


  @doc """
  normal_at(object,world_point)
  object = sphere()
  world_point = point(x,y,z)
  compute normals to a surface in following steps
  invert the object transform which is used twice in the algorithm
  multiply by world point to get the object space origin point
  subtract the world origin to get the object normal
  transpose the inverse transform  and multiply by object normal
  we now hae the world normal
  apply hack w=0 to convert result to a vector
  normalize the resulting surface ormal
  """
  def normal_at(object,world_point) do
    objt = inverse(object.transform) 
    {x,y,z,_w} =  
    objt 
    |> matrix_multiply(world_point)
    |> subtract_tuple(point(0,0,0))
    |> matrix_multiply(transpose(objt))
    # set world normal w to 0
    # normalize the result
    normalize({x,y,z,0})
  end

  @doc """
  reflect computes the reflected vector for a surface when light hits
  from an angle
  inputs: 
  incident vvector
  normal vector
  returns reflected vector

  """ 
  def reflect(incident,normal) do
    d = dot(incident,normal) * 2 
    v = scale_tuple(normal,d)
    subtract_tuple(incident,v)
  end
end

